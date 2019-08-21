require 'digest'

RSpec.describe Percy::Cli::SnapshotRunner do
  subject(:runner) { Percy::Cli::SnapshotRunner.new }

  let(:root_dir) { File.expand_path('../testdata/', __FILE__) }

  # Used for testing that paths are collapsed before use.r
  let(:root_dir_relative) { root_dir + '/../testdata' }

  describe '#initialize' do
    it 'passes client info down to the lower level Percy client' do
      expect(runner.client.client_info).to eq("percy-cli/#{Percy::Cli::VERSION}")
    end
  end

  describe '#run' do
    xit 'snapshots a root directory of static files' do
      # TODO(fotinakis): tests for the full flow.
    end
  end

  describe '#rescue_connection_failures' do
    it 'returns block result on success' do
      result = runner._rescue_connection_failures { true }

      expect(result).to be true
      expect(runner._failed?).to be false
    end

    it 'makes block safe from quota exceeded errors' do
      result = runner._rescue_connection_failures do
        raise Percy::Client::PaymentRequiredError.new(409, 'POST', '', '')
      end

      expect(result).to be_nil
      expect(runner._failed?).to be true
    end

    it 'makes block safe from server errors' do
      result = runner._rescue_connection_failures do
        raise Percy::Client::ServerError.new(502, 'POST', '', '')
      end

      expect(result).to be_nil
      expect(runner._failed?).to be true
    end

    it 'makes block safe from ConnectionFailed' do
      result = runner._rescue_connection_failures { raise Percy::Client::ConnectionFailed }

      expect(result).to be_nil
      expect(runner._failed?).to be true
    end

    it 'makes block safe from UnauthorizedError' do
      result = runner._rescue_connection_failures do
        raise Percy::Client::UnauthorizedError.new(401, 'GET', '', '')
      end

      expect(result).to be_nil
      expect(runner._failed?).to be true
    end

    it 'makes block safe from TimeoutError' do
      result = runner._rescue_connection_failures { raise Percy::Client::TimeoutError }

      expect(result).to be_nil
      expect(runner._failed?).to be true
    end

    it 'requires a block' do
      expect { runner._rescue_connection_failures }.to raise_error(ArgumentError)
    end
  end

  describe '#_find_root_paths' do
    it 'returns only the HTML files in the directory' do
      paths = runner._find_root_paths root_dir

      expected_results = [
        File.join(root_dir, 'index.html'),
        File.join(root_dir, 'ignore.html'),
        File.join(root_dir, 'skip.html'),
        File.join(root_dir, 'subdir/test.html'),
        # Make sure file symlinks are followed.
        File.join(root_dir, 'subdir/test_symlink.html'),
      ]

      # Symlinked folders don't work out-of-the-box upon git clone on windows
      unless Gem.win_platform?
        expected_results += [
          # Make sure directory symlinks are followed.
          File.join(root_dir, 'subdir_symlink/test.html'),
          File.join(root_dir, 'subdir_symlink/test_symlink.html'),
        ]
      end

      expect(paths).to match_array(expected_results)
    end

    it 'returns only the files matching the snapshots_regex' do
      opts = {snapshots_regex: 'xml'}
      paths = runner._find_root_paths(root_dir, opts)

      expected_results = [
        File.join(root_dir, 'index.xml'),
        File.join(root_dir, 'subdir/test.xml'),
      ]

      # Symlinked folders don't work out-of-the-box upon git clone on windows
      unless Gem.win_platform?
        expected_results += [
          # Make sure directory symlinks are followed.
          File.join(root_dir, 'subdir_symlink/test.xml'),
        ]
      end

      expect(paths).to match_array(expected_results)
    end

    it 'skips files passed into the ignore_regex option' do
      opts = {ignore_regex: 'skip|ignore'}
      paths = runner._find_root_paths(root_dir, opts)

      expected_results = [
        File.join(root_dir, 'index.html'),
        File.join(root_dir, 'subdir/test.html'),
        # Make sure file symlinks are followed.
        File.join(root_dir, 'subdir/test_symlink.html'),
      ]

      # Symlinked folders don't work out-of-the-box upon git clone on windows
      unless Gem.win_platform?
        expected_results += [
          # Make sure directory symlinks are followed.
          File.join(root_dir, 'subdir_symlink/test.html'),
          File.join(root_dir, 'subdir_symlink/test_symlink.html'),
        ]
      end

      expect(paths).to match_array(expected_results)
    end
  end

  describe '#_find_resource_paths' do
    it 'returns only the related static files in the directory' do
      paths = runner._find_resource_paths root_dir

      expected_results = [
        File.join(root_dir, 'css/base.css'),
        File.join(root_dir, 'css/test with spaces.css'),
        File.join(root_dir, 'images/jellybeans.png'),
        File.join(root_dir, 'images/large-file-skipped.png'),
        # Make sure file symlinks are followed.
        File.join(root_dir, 'images/jellybeans-symlink.png'),
      ]

      # Symlinked folders don't work out-of-the-box upon git clone on windows
      unless Gem.win_platform?
        expected_results += [
          # Make sure directory symlinks are followed.
          File.join(root_dir, 'images_symlink/jellybeans.png'),
          File.join(root_dir, 'images_symlink/large-file-skipped.png'),
          File.join(root_dir, 'images_symlink/jellybeans-symlink.png'),
        ]
      end

      expect(paths).to match_array(expected_results)
    end
  end

  describe '#_list_resources' do
    it 'returns resource objects' do
      paths = [File.join(root_dir, 'css/base.css')]
      options = {baseurl: '/', strip_prefix: root_dir}
      resources = runner._list_resources paths, options

      expect(resources.length).to eq(1)
      expect(resources.first.sha).to eq(Digest::SHA256.hexdigest(File.read(paths.first)))
      expect(resources.first.is_root).to be_nil
      expect(resources.first.content).to be_nil
      expect(resources.first.path).to eq(paths.first)
    end

    it 'correctly strips the prefix from resource_url' do
      paths = [File.join(root_dir, 'index.html')]
      options = {baseurl: '/', strip_prefix: root_dir_relative, is_root: true}
      resources = runner._list_resources paths, options

      expect(resources.length).to eq(1)
      expect(resources.first.resource_url).to eq('/index.html')
    end

    it 'returns resource objects with is_root set if given' do
      paths = [File.join(root_dir, 'index.html')]
      options = {baseurl: '/', strip_prefix: root_dir, is_root: true}
      resources = runner._list_resources paths, options

      expect(resources.length).to eq(1)
      expect(resources.first.resource_url).to eq('/index.html')
      expect(resources.first.sha).to eq(Digest::SHA256.hexdigest(File.read(paths.first)))
      expect(resources.first.is_root).to be_truthy
      expect(resources.first.content).to be_nil
      expect(resources.first.path).to eq(paths.first)
    end

    it 'encodes the resource_url' do
      paths = [File.join(root_dir, 'css/test with spaces.css')]
      options = {baseurl: '/', strip_prefix: root_dir}
      resources = runner._list_resources paths, options

      expect(resources.length).to eq(1)
      expect(resources.first.resource_url).to eq('/css/test%20with%20spaces.css')
      expect(resources.first.sha).to eq(Digest::SHA256.hexdigest(File.read(paths.first)))
      expect(resources.first.is_root).to be_nil
      expect(resources.first.content).to be_nil
      expect(resources.first.path).to eq(paths.first)
    end

    it 'prepends the baseurl if given' do
      paths = [File.join(root_dir, 'index.html')]
      options = {strip_prefix: root_dir, is_root: true, baseurl: '/test baseurl/'}
      resources = runner._list_resources paths, options

      expect(resources.length).to eq(1)
      expect(resources.first.resource_url).to eq('/test%20baseurl/index.html')
      expect(resources.first.sha).to eq(Digest::SHA256.hexdigest(File.read(paths.first)))
      expect(resources.first.is_root).to be_truthy
      expect(resources.first.content).to be_nil
      expect(resources.first.path).to eq(paths.first)
    end
  end

  describe '#upload_snapshot' do
    xit 'uploads the given resources to the build' do
      # TODO(fotinakis): tests for this.
    end
  end
end
