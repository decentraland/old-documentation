RSpec.describe Percy::Client::Builds, :vcr do
  let(:content) { "hello world! #{Percy::Client::Builds.name}" }
  let(:sha) { Digest::SHA256.hexdigest(content) }

  describe '#create_build' do
    it 'creates a build' do
      # Whitebox test to check POST data.
      expect_any_instance_of(Percy::Client).to \
        receive(:post)
        .with(
          /\/api\/v1\/builds\//,
          'data' => {
            'type' => 'builds',
            'attributes' => {
              'branch' => kind_of(String),
              'target-branch' => nil,
              'target-commit-sha' => nil,
              'commit-sha' => kind_of(String),
              'commit-committed-at' => kind_of(String),
              'commit-author-name' => kind_of(String),
              'commit-author-email' => kind_of(String),
              'commit-committer-name' => kind_of(String),
              'commit-committer-email' => kind_of(String),
              'commit-message' => kind_of(String),
              'pull-request-number' => anything,
              'parallel-nonce' => nil,
              'parallel-total-shards' => nil,
            },
          },
        ).and_call_original

      build = Percy.create_build()
      expect(build).to be
      expect(build['data']).to be
      expect(build['data']['id']).to be
      expect(build['data']['type']).to eq('builds')
      expect(build['data']['attributes']['state']).to eq('pending')
      expect(build['data']['attributes']['is-pull-request']).to be_truthy
      expect(build['data']['attributes']['pull-request-number']).to eq(123)
      expect(build['data']['relationships']['missing-resources']).to be
      expect(build['data']['relationships']['missing-resources']['data']).to_not be
    end

    it 'accepts optional resources' do
      resources = []
      resources << Percy::Client::Resource.new('/css/test.css', sha: sha)

      build = Percy.create_build(resources: resources)
      expect(build).to be
      expect(build['data']).to be
      expect(build['data']['id']).to be
      expect(build['data']['type']).to eq('builds')
      expect(build['data']['attributes']['state']).to eq('pending')
      expect(build['data']['attributes']['is-pull-request']).to be_truthy
      expect(build['data']['attributes']['pull-request-number']).to eq(123)
      expect(build['data']['relationships']['missing-resources']).to be
      expect(build['data']['relationships']['missing-resources']['data']).to be
      expect(build['data']['relationships']['missing-resources']['data'].length).to eq(1)
    end

    context 'with env vars configured' do
      before(:each) do
        ENV['PERCY_BRANCH'] = 'foo-branch'
        ENV['PERCY_TARGET_BRANCH'] = 'bar-branch'
        ENV['PERCY_TARGET_COMMIT'] = 'test-target-commit'
        ENV['PERCY_PULL_REQUEST'] = '123'
        ENV['PERCY_PARALLEL_NONCE'] = 'nonce'
        ENV['PERCY_PARALLEL_TOTAL'] = '4'
      end

      after(:each) do
        ENV['PERCY_BRANCH'] = nil
        ENV['PERCY_TARGET_BRANCH'] = nil
        ENV['PERCY_TARGET_COMMIT'] = nil
        ENV['PERCY_PULL_REQUEST'] = nil
        ENV['PERCY_PARALLEL_NONCE'] = nil
        ENV['PERCY_PARALLEL_TOTAL'] = nil
      end

      it 'passes through some attributes from environment' do
        # Whitebox test to check POST data.
        expect_any_instance_of(Percy::Client).to \
          receive(:post)
          .with(
            /\/api\/v1\/builds\//,
            'data' => {
              'type' => 'builds',
              'attributes' => {
                'branch' => 'foo-branch',
                'target-branch' => 'bar-branch',
                'target-commit-sha' => 'test-target-commit',
                'commit-sha' => kind_of(String),
                'commit-committed-at' => kind_of(String),
                'commit-author-name' => kind_of(String),
                'commit-author-email' => kind_of(String),
                'commit-committer-name' => kind_of(String),
                'commit-committer-email' => kind_of(String),
                'commit-message' => kind_of(String),
                'pull-request-number' => '123',
                'parallel-nonce' => 'nonce',
                'parallel-total-shards' => 4,
              },
            },
          )

        Percy.create_build()
      end
    end

    context 'when in a parallel test environment' do
      it 'passes through parallelism variables' do
        build = Percy.create_build(
          parallel_nonce: 'nonce',
          parallel_total_shards: 2,
        )
        expect(build['data']['attributes']['parallel-nonce']).to eq('nonce')
        expect(build['data']['attributes']['parallel-total-shards']).to eq(2)
      end
    end
  end

  describe '#finalize_build' do
    it 'finalizes a build' do
      build = Percy.create_build()
      result = Percy.finalize_build(build['data']['id'])
      expect(result).to eq('success' => true)
    end
  end
end
