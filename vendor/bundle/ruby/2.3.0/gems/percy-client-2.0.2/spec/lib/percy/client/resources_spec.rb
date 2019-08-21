require 'digest'

# rubocop:disable RSpec/MultipleDescribes
RSpec.describe Percy::Client::Resources, :vcr do
  let(:content) { "hello world! #{Percy::Client::Resources.name}" }
  let(:sha) { Digest::SHA256.hexdigest(content) }

  describe '#upload_resource' do
    it 'returns true with success' do
      build = Percy.create_build()
      resources = [Percy::Client::Resource.new('/foo/test.html', sha: sha, is_root: true)]
      Percy.create_snapshot(build['data']['id'], resources, name: 'homepage')

      # Verify that upload_resource hides conflict errors, though they are output to stderr.
      expect(Percy.upload_resource(build['data']['id'], content)).to be_truthy
      expect(Percy.upload_resource(build['data']['id'], content)).to be_truthy
    end
  end
end

RSpec.describe Percy::Client::Resource do
  let(:content) { "hello world! #{Percy::Client::Resource.name}" }
  let(:sha) { Digest::SHA256.hexdigest(content) }

  it 'can be initialized with minimal data' do
    resource = Percy::Client::Resource.new('/foo.html', sha: sha)
    expect(resource.serialize).to eq(
      'type' => 'resources',
      'id' => sha,
      'attributes' => {
        'resource-url' => '/foo.html',
        'mimetype' => nil,
        'is-root' => nil,
      },
    )
  end
  it 'can be initialized with all data' do
    resource = Percy::Client::Resource.new(
      '/foo new.html',
      sha: sha,
      is_root: true,
      mimetype: 'text/html',
      content: content,
    )
    expect(resource.serialize).to eq(
      'type' => 'resources',
      'id' => sha,
      'attributes' => {
        'resource-url' => '/foo%20new.html',
        'mimetype' => 'text/html',
        'is-root' => true,
      },
    )
  end
  it 'errors if not given sha or content' do
    expect { Percy::Client::Resource.new('/foo.html') }.to raise_error(ArgumentError)
  end

  describe 'object equality' do
    subject(:resource) do
      Percy::Client::Resource.new('/some-content', sha: sha, mimetype: mimetype)
    end

    let(:sha) { '123456' }
    let(:mimetype) { 'text/plain' }

    describe 'two resources with same properties' do
      let(:other) { Percy::Client::Resource.new('/some-content', sha: sha, mimetype: mimetype) }

      it { should eq(other) }
      it { should eql(other) }
      it { expect(resource.hash).to eq(other.hash) }
      it('makes their array unique') { expect([resource, other].uniq).to eq([resource]) }
    end

    describe 'two resources with different sha' do
      let(:other) do
        Percy::Client::Resource.new('/some-content', sha: sha.reverse, mimetype: mimetype)
      end

      it { should_not eq(other) }
      it { should_not eql(other) }
      it { expect(resource.hash).to_not eq(other.hash) }
      it('makes array unique') { expect([resource, other].uniq).to eq([resource, other]) }
    end

    describe 'two resources with different url' do
      let(:other) do
        Percy::Client::Resource.new('/different-content', sha: sha, mimetype: mimetype)
      end

      it { should_not eq(other) }
      it { should_not eql(other) }
      it { expect(resource.hash).to_not eq(other.hash) }
      it('makes array unique') { expect([resource, other].uniq).to eq([resource, other]) }
    end

    describe 'two resources with different mimetype' do
      let(:other) { Percy::Client::Resource.new('/some-content', sha: sha, mimetype: 'text/css') }

      it { should_not eq(other) }
      it { should_not eql(other) }
      it { expect(resource.hash).to_not eq(other.hash) }
      it('makes array unique') { expect([resource, other].uniq).to eq([resource, other]) }
    end
  end
end
# rubocop:enable RSpec/MultipleDescribes
