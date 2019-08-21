RSpec.describe Percy::Client::Connection do
  let(:user_agent) do
    "Percy/#{api_version} #{client_info} percy-client/#{Percy::Client::VERSION} "\
    "(#{environment_info}; ruby/#{ruby_version}; #{ci_name}/#{ci_version})"
  end
  let(:content_type) { 'application/vnd.api+json' }
  let(:api_version) { 'v1' }
  let(:ruby_version) { '2.2.6p396' }
  let(:client_info) { 'percy-capybara/3.1.0' }
  let(:environment_info) { 'Rails/4.2.1' }
  let(:ci_name) { :gitlab }
  let(:ci_version) { '8.14.3-ee' }
  let(:uri) { "#{Percy.config.api_url}/test" }

  SERVER_ERROR_CODES = ((500..504).to_a + (520..530).to_a).freeze

  shared_examples_for 'a connection that sets headers with HTTP method' do |http_method|
    it 'sets headers' do
      stub_request(http_method, uri)
        .with(headers: {'User-Agent' => user_agent, 'Content-Type' => content_type})
        .to_return(body: {foo: true}.to_json)

      expect(Percy.client).to receive(:_api_version).and_return(api_version)
      expect(Percy.client).to receive(:_ruby_version).and_return(ruby_version)

      expect(Percy.client).to receive(:client_info).and_return(client_info)
      expect(Percy.client).to receive(:environment_info).and_return(environment_info)

      expect(Percy::Client::Environment).to receive(:current_ci).and_return(ci_name)
      expect(Percy::Client::Environment).to receive(:ci_version).and_return(ci_version)

      expect(response).to eq('foo' => true)
    end
  end

  describe '#get' do
    subject(:response) { Percy.client.get(uri) }

    it_behaves_like 'a connection that sets headers with HTTP method', :get

    it 'performs a GET request to the api_url and parses response' do
      stub_request(:get, uri).to_return(body: {foo: true}.to_json)
      expect(response).to eq('foo' => true)
    end

    it 'raises customized timeout errors' do
      stub_request(:get, uri).to_raise(Faraday::TimeoutError)
      expect { response }.to raise_error(Percy::Client::TimeoutError)
    end

    it 'raises customized connection failed errors' do
      stub_request(:get, uri).to_raise(Faraday::ConnectionFailed)
      expect { response }.to raise_error(Percy::Client::ConnectionFailed)
    end

    it 'retries on 5XX errors' do
      SERVER_ERROR_CODES.each do |error_code|
        stub_request(:get, uri)
          .to_return(body: {foo: true}.to_json, status: error_code)
          .then.to_return(body: {foo: true}.to_json, status: 200)

        expect(response).to eq('foo' => true)
      end
    end

    it 'raises error after 3 retries' do
      stub_request(:get, uri)
        .to_return(body: {foo: true}.to_json, status: 502).times(3)

      expect { response }.to raise_error(Percy::Client::BadGatewayError)
    end
  end

  describe '#post' do
    subject(:response) { Percy.client.post(uri, {}) }

    it_behaves_like 'a connection that sets headers with HTTP method', :post

    it 'performs a POST request to the api_url and parses response' do
      stub_request(:post, uri).to_return(body: {foo: true}.to_json)
      expect(response).to eq('foo' => true)
    end

    it 'passes through arguments' do
      stub_request(:post, uri)
        .with(headers: {'User-Agent' => user_agent, 'Content-Type' => content_type})
        .to_return(body: {foo: true}.to_json)

      expect(Percy.client).to receive(:_user_agent).and_return(user_agent)
      expect(response).to eq('foo' => true)
    end

    it 'raises customized timeout errors' do
      stub_request(:post, uri).to_raise(Faraday::TimeoutError)
      expect { response }.to raise_error(Percy::Client::TimeoutError)
    end

    it 'raises customized connection failed errors' do
      stub_request(:post, uri).to_raise(Faraday::ConnectionFailed)
      expect { response }.to raise_error(Percy::Client::ConnectionFailed)
    end

    context 'with retries enabled' do
      subject(:response) { Percy.client.post(uri, {}, retries: 3) }

      it 'raises an exception on retry exhaustion' do
        stub_request(:post, uri).to_raise(Faraday::TimeoutError)
        expect { response }.to raise_error(Percy::Client::TimeoutError)
      end
    end

    shared_examples_for 'HTTP status raises custom error class' do |http_status, error_class|
      subject(:request) { Percy.client.post(uri, {}, retries: 0) }

      it 'raises custom error classes for some HTTP errors' do
        stub_request(:post, uri).to_return(body: {foo: true}.to_json, status: http_status.to_i)
        expect { request }.to raise_error(error_class)
      end
    end

    http_errors = {
      '400' => Percy::Client::BadRequestError,
      '401' => Percy::Client::UnauthorizedError,
      '402' => Percy::Client::PaymentRequiredError,
      '403' => Percy::Client::ForbiddenError,
      '404' => Percy::Client::NotFoundError,
      '409' => Percy::Client::ConflictError,
      '500' => Percy::Client::InternalServerError,
      '502' => Percy::Client::BadGatewayError,
      '503' => Percy::Client::ServiceUnavailableError,
      '504' => Percy::Client::GatewayTimeoutError,
      '520' => Percy::Client::CloudflareError,
      '530' => Percy::Client::CloudflareError,
    }

    http_errors.each do |http_status, error_class|
      include_examples 'HTTP status raises custom error class', http_status, error_class
    end

    it 'retries on server errors' do
      SERVER_ERROR_CODES.each do |error_code|
        stub_request(:post, uri)
          .to_return(body: {foo: true}.to_json, status: 500)
          .then.to_return(body: {foo: true}.to_json, status: 200)

        expect(response).to eq('foo' => true)
      end
    end

    it 'raises error after 3 retries' do
      stub_request(:post, uri)
        .to_return(body: {foo: true}.to_json, status: 502).times(3)

      expect { response }.to raise_error(Percy::Client::BadGatewayError)
    end
  end
end
