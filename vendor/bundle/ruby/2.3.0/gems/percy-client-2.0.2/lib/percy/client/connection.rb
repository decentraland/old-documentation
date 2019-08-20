require 'openssl'
require 'uri'
require 'faraday'

module Percy
  class Client
    module Connection
      class NiceErrorMiddleware < Faraday::Response::Middleware
        CLIENT_ERROR_STATUS_RANGE = 400...600

        def on_complete(env)
          error_class = nil

          case env[:status]
          when 400
            error_class = Percy::Client::BadRequestError
          when 401
            error_class = Percy::Client::UnauthorizedError
          when 402
            error_class = Percy::Client::PaymentRequiredError
          when 403
            error_class = Percy::Client::ForbiddenError
          when 404
            error_class = Percy::Client::NotFoundError
          when 409
            error_class = Percy::Client::ConflictError
          when 500
            error_class = Percy::Client::InternalServerError
          when 502
            error_class = Percy::Client::BadGatewayError
          when 503
            error_class = Percy::Client::ServiceUnavailableError
          when 504
            error_class = Percy::Client::GatewayTimeoutError
          when 520..530
            error_class = Percy::Client::CloudflareError
          when CLIENT_ERROR_STATUS_RANGE # Catchall.
            error_class = Percy::Client::HttpError
          end

          return unless error_class

          raise error_class.new(
            env.status, env.method.upcase, env.url, env.body,
            "Got #{env.status} (#{env.method.upcase} #{env.url}):\n#{env.body}",
          )
        end
      end

      def connection
        return @connection if defined?(@connection)

        parsed_uri = URI.parse(config.api_url)
        base_url = "#{parsed_uri.scheme}://#{parsed_uri.host}:#{parsed_uri.port}"

        @connection = Faraday.new(url: base_url) do |faraday|
          faraday.request :token_auth, config.access_token if config.access_token
          faraday.use Percy::Client::Connection::NiceErrorMiddleware
          faraday.adapter :excon
        end

        @connection
      end

      def get(path, options = {})
        retries = options[:retries] || 3

        begin
          response = connection.get do |request|
            request.url(path)
            request.headers.merge! _headers
          end
        rescue Faraday::TimeoutError
          raise Percy::Client::TimeoutError
        rescue Faraday::ConnectionFailed
          raise Percy::Client::ConnectionFailed
        rescue Percy::Client::ServerError => e
          # Retry on 5XX errors.
          if (retries -= 1) >= 0
            sleep(rand(1..3))
            retry
          end
          raise e
        end
        JSON.parse(response.body)
      end

      def post(path, data, options = {})
        retries = options[:retries] || 3

        begin
          response = connection.post do |request|
            request.url(path)
            request.headers.merge! _headers
            request.body = data.to_json
          end
        rescue Faraday::TimeoutError
          if (retries -= 1) >= 0
            retry
          end
          raise Percy::Client::TimeoutError
        rescue Faraday::ConnectionFailed
          raise Percy::Client::ConnectionFailed
        rescue Percy::Client::ServerError => e
          # Retry on 5XX errors.
          if (retries -= 1) >= 0
            sleep(rand(1..3))
            retry
          end

          raise e
        end

        JSON.parse(response.body)
      end

      def _headers
        {
          'Content-Type' => 'application/vnd.api+json',
          'User-Agent' => _user_agent,
        }
      end

      def _user_agent
        @_user_agent ||= begin
          client = [
            "Percy/#{_api_version}",
            client_info,
            "percy-client/#{VERSION}",
          ].compact.join(' ')

          environment = [
            environment_info,
            "ruby/#{_ruby_version}",
            Percy::Client::Environment.ci_info,
          ].compact.join('; ')

          "#{client} (#{environment})"
        end
      end

      def _reset_user_agent
        @_user_agent = nil
      end

      def _api_version
        config.api_url.match(/\w+$/).to_s
      end

      def _ruby_version
        "#{RUBY_VERSION}p#{RUBY_PATCHLEVEL}"
      end
    end
  end
end
