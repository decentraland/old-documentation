RSpec.describe Percy::Client::Snapshots, :vcr do
  let(:content) { "hello world! #{described_class.name}" }
  let(:sha) { Digest::SHA256.hexdigest(content) }

  describe '#create_snapshot' do
    it 'creates a snapshot' do
      build = Percy.create_build()
      resources = []
      resources << Percy::Client::Resource.new('/foo/test.html', sha: sha, is_root: true)
      resources << Percy::Client::Resource.new('/css/test.css', sha: sha)

      # Whitebox test to catch POST data that is sent but is not returned in the API response.
      expect_any_instance_of(Percy::Client).to \
        receive(:post)
        .with(
          /snapshots\/$/,
          'data' => {
            'type' => 'snapshots',
            'attributes' => {
              'name' => 'homepage',
              'enable-javascript' => true,
              'minimum-height' => nil,
              'widths' => Percy.config.default_widths,
            },
            'relationships' => {
              'resources' => {
                'data' => [
                  {
                    'type' => 'resources',
                    'id' => kind_of(String),
                    'attributes' => {
                      'resource-url' => '/foo/test.html',
                      'mimetype' => nil,
                      'is-root' => true,
                    },
                  },
                  {
                    'type' => 'resources',
                    'id' => kind_of(String),
                    'attributes' => {
                      'resource-url' => '/css/test.css',
                      'mimetype' => nil,
                      'is-root' => nil,
                    },
                  },
                ],
              },
            },
          },
        )
        .and_call_original

      snapshot = Percy.create_snapshot(
        build['data']['id'],
        resources,
        name: 'homepage',
        enable_javascript: true,
      )

      expect(snapshot['data']).to be
      expect(snapshot['data']['id']).to be
      expect(snapshot['data']['type']).to eq('snapshots')
      expect(snapshot['data']['attributes']['name']).to eq('homepage')
      expect(snapshot['data']['relationships']['missing-resources']).to be
    end
    it 'passes through certain arguments' do
      build = Percy.create_build()
      resources = []
      resources << Percy::Client::Resource.new('/foo/test.html', sha: sha, is_root: true)
      resources << Percy::Client::Resource.new('/css/test.css', sha: sha)

      # Whitebox test to catch POST data that is sent but is not returned in the API response.
      expect_any_instance_of(Percy::Client).to \
        receive(:post)
        .with(
          /snapshots\/$/,
          'data' => {
            'type' => 'snapshots',
            'attributes' => {
              'name' => 'homepage',
              'enable-javascript' => nil,
              'minimum-height' => 700,
              'widths' => [320, 1280],
            },
            'relationships' => {
              'resources' => {
                'data' => [
                  {
                    'type' => 'resources',
                    'id' => kind_of(String),
                    'attributes' => {
                      'resource-url' => '/foo/test.html',
                      'mimetype' => nil,
                      'is-root' => true,
                    },
                  },
                  {
                    'type' => 'resources',
                    'id' => kind_of(String),
                    'attributes' => {
                      'resource-url' => '/css/test.css',
                      'mimetype' => nil,
                      'is-root' => nil,
                    },
                  },
                ],
              },
            },
          },
        )
        .and_call_original

      snapshot = Percy.create_snapshot(
        build['data']['id'],
        resources,
        name: 'homepage',
        widths: [320, 1280],
        minimum_height: 700,
      )

      expect(snapshot['data']).to be
      expect(snapshot['data']['id']).to be
      expect(snapshot['data']['type']).to eq('snapshots')
      expect(snapshot['data']['attributes']['name']).to eq('homepage')
      expect(snapshot['data']['relationships']['missing-resources']).to be
    end
    it 'fails if no resources are given' do
      build = Percy.create_build()
      expect do
        Percy.create_snapshot(build['data']['id'], [])
      end.to raise_error(Percy::Client::HttpError)
    end
  end
  describe '#finalize_snapshot' do
    it 'finalizes a snapshot' do
      build = Percy.create_build()
      resources = []
      resources << Percy::Client::Resource.new('/foo/test.html', sha: sha, is_root: true)
      resources << Percy::Client::Resource.new('/css/test.css', sha: sha)
      snapshot = Percy.create_snapshot(build['data']['id'], resources, name: 'homepage')

      result = Percy.finalize_snapshot(snapshot['data']['id'])
      expect(result).to eq('success' => true)
    end
  end
end
