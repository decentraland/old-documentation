module Percy
  class Client
    module Environment
      GIT_FORMAT_LINES = [
        'COMMIT_SHA:%H',
        'AUTHOR_NAME:%an',
        'AUTHOR_EMAIL:%ae',
        'COMMITTER_NAME:%cn',
        'COMMITTER_EMAIL:%ce',
        'COMMITTED_DATE:%ai',
        # Note: order is important, this must come last because the regex is a multiline match.
        'COMMIT_MESSAGE:%B',
      ].freeze

      class Error < RuntimeError; end
      class RepoNotFoundError < RuntimeError; end

      def self.current_ci
        return :travis if ENV['TRAVIS_BUILD_ID']
        return :jenkins if ENV['JENKINS_URL'] && ENV['ghprbPullId'] # Pull Request Builder plugin.
        return :circle if ENV['CIRCLECI']
        return :codeship if ENV['CI_NAME'] && ENV['CI_NAME'] == 'codeship'
        return :drone if ENV['DRONE'] == 'true'
        return :semaphore if ENV['SEMAPHORE'] == 'true'
        return :buildkite if ENV['BUILDKITE'] == 'true'
        return :gitlab if ENV['GITLAB_CI'] == 'true'
      end

      def self.ci_version
        return unless current_ci == :gitlab
        ENV['CI_SERVER_VERSION']
      end

      def self.ci_info
        [current_ci, ci_version].compact.join('/')
      end

      # @return [Hash] All commit data from the current commit. Might be empty if commit data could
      # not be found.
      def self.commit
        # Try getting data from git itself.
        # If this has a result, it means git is present in the system.
        git_data_from_git = _git_commit_output

        parse = ->(regex) { (git_data_from_git && git_data_from_git.match(regex) || [])[1] }

        commit_sha = _commit_sha || parse.call(/COMMIT_SHA:(.*)/)

        {
          # The only required attribute:
          branch: branch,
          # An optional but important attribute:
          sha: commit_sha,

          # Optional attributes:
          # If we have the git information, read from those rather than env vars.
          # The GIT_ environment vars are from the Jenkins Git Plugin, but could be
          # used generically. This behavior may change in the future.
          message: parse.call(/COMMIT_MESSAGE:(.*)/),
          committed_at: parse.call(/COMMITTED_DATE:(.*)/),
          author_name: parse.call(/AUTHOR_NAME:(.*)/) || ENV['GIT_AUTHOR_NAME'],
          author_email: parse.call(/AUTHOR_EMAIL:(.*)/) || ENV['GIT_AUTHOR_EMAIL'],
          committer_name: parse.call(/COMMITTER_NAME:(.*)/) || ENV['GIT_COMMITTER_NAME'],
          committer_email: parse.call(/COMMITTER_EMAIL:(.*)/) || ENV['GIT_COMMITTER_EMAIL'],
        }
      end

      # @private
      def self._git_commit_output
        raw_git_output = _raw_commit_output(_commit_sha) if _commit_sha
        raw_git_output ||= _raw_commit_output('HEAD')
        if raw_git_output && raw_git_output.encoding.to_s == 'US-ASCII'
          raw_git_output = raw_git_output.force_encoding('UTF-8')
        end
        raw_git_output
      end

      # @private
      def self._commit_sha
        return ENV['PERCY_COMMIT'] if ENV['PERCY_COMMIT']

        case current_ci
        when :jenkins
          # Pull Request Builder Plugin OR Git Plugin.
          ENV['ghprbActualCommit'] || ENV['GIT_COMMIT']
        when :travis
          ENV['TRAVIS_COMMIT']
        when :circle
          ENV['CIRCLE_SHA1']
        when :codeship
          ENV['CI_COMMIT_ID']
        when :drone
          ENV['DRONE_COMMIT']
        when :semaphore
          ENV['REVISION']
        when :buildkite
          # Buildkite mixes SHAs and non-SHAs in BUILDKITE_COMMIT, so we return null if non-SHA.
          return if ENV['BUILDKITE_COMMIT'] == 'HEAD'
          ENV['BUILDKITE_COMMIT']
        when :gitlab
          ENV['CI_COMMIT_SHA']
        end
      end

      # @private
      def self._raw_commit_output(commit_sha)
        format = GIT_FORMAT_LINES.join('%n') # "git show" format uses %n for newlines.
        output = if Gem.win_platform?
          `git show --quiet #{commit_sha} --format="#{format}" 2> NUL`.strip
        else
          `git show --quiet #{commit_sha} --format="#{format}" 2> /dev/null`.strip
        end
        return if $CHILD_STATUS.to_i != 0
        output
      end

      def self.target_commit_sha
        return ENV['PERCY_TARGET_COMMIT'] if ENV['PERCY_TARGET_COMMIT']
      end

      # The name of the current branch.
      def self.branch
        return ENV['PERCY_BRANCH'] if ENV['PERCY_BRANCH']

        result = case current_ci
        when :jenkins
          ENV['ghprbSourceBranch']
        when :travis
          if pull_request_number
            ENV['TRAVIS_PULL_REQUEST_BRANCH']
          else
            ENV['TRAVIS_BRANCH']
          end
        when :circle
          ENV['CIRCLE_BRANCH']
        when :codeship
          ENV['CI_BRANCH']
        when :drone
          ENV['DRONE_BRANCH']
        when :semaphore
          ENV['BRANCH_NAME']
        when :buildkite
          ENV['BUILDKITE_BRANCH']
        when :gitlab
          ENV['CI_COMMIT_REF_NAME']
        else
          _raw_branch_output
        end

        if result == ''
          STDERR.puts '[percy] Warning: not in a git repo, no branch detected.'
          result = nil
        end
        result
      end

      # The target branch to compare against (if unset, Percy will pick master).
      def self.target_branch
        return ENV['PERCY_TARGET_BRANCH'] if ENV['PERCY_TARGET_BRANCH']
      end

      # @private
      def self._raw_branch_output
        # Discover from local git repo branch name.
        if Gem.win_platform?
          `git rev-parse --abbrev-ref HEAD 2> NUL`.strip
        else
          `git rev-parse --abbrev-ref HEAD 2> /dev/null`.strip
        end
      end
      class << self; private :_raw_branch_output; end

      def self.pull_request_number
        return ENV['PERCY_PULL_REQUEST'] if ENV['PERCY_PULL_REQUEST']

        case current_ci
        when :jenkins
          # GitHub Pull Request Builder plugin.
          ENV['ghprbPullId']
        when :travis
          ENV['TRAVIS_PULL_REQUEST'] if ENV['TRAVIS_PULL_REQUEST'] != 'false'
        when :circle
          if ENV['CI_PULL_REQUESTS'] && ENV['CI_PULL_REQUESTS'] != ''
            ENV['CI_PULL_REQUESTS'].split('/')[-1]
          end
        when :codeship
          # Unfortunately, codeship always returns 'false' for CI_PULL_REQUEST. For now, return nil.
          nil
        when :drone
          ENV['CI_PULL_REQUEST']
        when :semaphore
          ENV['PULL_REQUEST_NUMBER']
        when :buildkite
          ENV['BUILDKITE_PULL_REQUEST'] if ENV['BUILDKITE_PULL_REQUEST'] != 'false'
        end
      end

      # A nonce which will be the same for all nodes of a parallel build, used to identify shards
      # of the same CI build. This is usually just the CI environment build ID.
      def self.parallel_nonce
        return ENV['PERCY_PARALLEL_NONCE'] if ENV['PERCY_PARALLEL_NONCE']

        case current_ci
        when :travis
          ENV['TRAVIS_BUILD_NUMBER']
        when :circle
          ENV['CIRCLE_WORKFLOW_WORKSPACE_ID'] || ENV['CIRCLE_BUILD_NUM']
        when :jenkins
          ENV['BUILD_NUMBER']
        when :codeship
          ENV['CI_BUILD_NUMBER']
        when :semaphore
          "#{ENV['SEMAPHORE_BRANCH_ID']}/#{ENV['SEMAPHORE_BUILD_NUMBER']}"
        when :buildkite
          ENV['BUILDKITE_BUILD_ID']
        when :gitlab
          ENV['CI_JOB_ID']
        end
      end

      def self.parallel_total_shards
        return Integer(ENV['PERCY_PARALLEL_TOTAL']) if ENV['PERCY_PARALLEL_TOTAL']

        var = case current_ci
        when :circle
          'CIRCLE_NODE_TOTAL'
        when :travis
          'CI_NODE_TOTAL'
        when :codeship
          'CI_NODE_TOTAL'
        when :semaphore
          'SEMAPHORE_THREAD_COUNT'
        when :buildkite
          'BUILDKITE_PARALLEL_JOB_COUNT'
        end
        Integer(ENV[var]) if var && ENV[var] && !ENV[var].empty?
      end

      # @private
      def self._get_origin_url
        `git config --get remote.origin.url`
      end
      class << self; private :_get_origin_url; end
    end
  end
end
