require 'commander'
require 'percy'
require 'percy/cli/version'
require 'percy/cli/snapshot_runner'

module Percy
  class Cli
    include Commander::Methods

    DEFAULT_NUM_THREADS = 3
    MAX_NUM_THREADS = 10

    def say(*args)
      $terminal.say(*args)
    end

    def say_error(*args)
      STDERR.puts(*args)
    end

    def run
      program :name, 'Percy CLI'
      program :version, Percy::Cli::VERSION
      program :description, 'Command-line interface for Percy (https://percy.io).'
      program :help_formatter, :compact
      default_command :help

      command :snapshot do |c|
        c.syntax = 'snapshot <root_dir>'
        c.description = 'Snapshot a folder of static files.'
        c.option \
          '--baseurl PATH',
          String,
          'The live URL base path. Defaults to "/". Set this if your site is hosted in ' \
          'a subdirectory in production that does not exist locally. If using Jekyll, this ' \
          'should be the same as your "baseurl" config.'
        c.option \
          '--strip_prefix PATH',
          String,
          'Directory path to strip from generated URLs. Defaults to the given root directory.'
        c.option \
          '--snapshots_regex REGEX',
          String,
          'Regular expression for matching the files to snapshot. Defaults to: "\.(html|htm)$"'
        c.option \
          '--ignore_regex REGEX',
          String,
          'Regular expression for matching the files NOT to snapshot. Default is nil.'
        c.option \
          '--widths CSV',
          String,
          'Comma-separated list of rendering widths for snapshots. Ex: 320,1280"'
        c.option \
          '--snapshot_limit NUM',
          Integer,
          'Max number of snapshots to upload, useful for testing. Default is unlimited.'
        c.option \
          '--[no-]enable_javascript',
          'Whether or not to enable JavaScript when rendering all snapshots. Default false.'
        c.option \
          '--include_all',
          "Whether to include all files in the directory as resources. By default only common ' +
          'website related file types are included."
        c.option \
          '--threads NUM',
          Integer,
          'Number of threads in pools for snapshot and resource uploads. ' \
          "Defaults to #{DEFAULT_NUM_THREADS}, max #{MAX_NUM_THREADS}."

        c.action do |args, options|
          options.default threads: DEFAULT_NUM_THREADS
          options.threads = MAX_NUM_THREADS if options.threads > MAX_NUM_THREADS
          options.enable_javascript = options.enable_javascript
          options.include_all = options.include_all
          options.widths = (options.widths || '').split(',')

          raise OptionParser::MissingArgument, 'root folder path is required' if args.empty?

          if args.length > 1
            raise OptionParser::MissingArgument, 'only a single root folder path can be given'
          end

          root_dir = args.first

          snapshot_runner = Percy::Cli::SnapshotRunner.new
          snapshot_runner.run(root_dir, options.__hash__)
        end
      end

      run!
    end
  end
end
