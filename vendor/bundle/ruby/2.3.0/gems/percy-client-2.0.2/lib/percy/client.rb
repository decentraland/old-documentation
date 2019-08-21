require 'json'
require 'percy/config'
require 'percy/client/environment'
require 'percy/client/connection'
require 'percy/client/version'
require 'percy/client/builds'
require 'percy/client/snapshots'
require 'percy/client/resources'

module Percy
  class Client
    include Percy::Client::Connection
    include Percy::Client::Builds
    include Percy::Client::Snapshots
    include Percy::Client::Resources

    class Error < RuntimeError; end
    class TimeoutError < Error; end
    class ConnectionFailed < Error; end
    class HttpError < Error
      attr_reader :status
      attr_reader :method
      attr_reader :url
      attr_reader :body

      def initialize(status, method, url, body, *args)
        @status = status
        @method = method
        @url = url
        @body = body
        super(*args)
      end
    end

    # 4xx
    class ClientError < HttpError; end

    # 400
    class BadRequestError < ClientError; end

    # 401
    class UnauthorizedError < ClientError; end

    # 402
    class PaymentRequiredError < ClientError; end

    # 403
    class ForbiddenError < ClientError; end

    # 404
    class NotFoundError < ClientError; end

    # 409
    class ConflictError < ClientError; end

    # 5xx
    class ServerError < HttpError; end

    # 500
    class InternalServerError < ServerError; end

    # 502
    class BadGatewayError < ServerError; end

    # 503
    class ServiceUnavailableError < ServerError; end

    # 504
    class GatewayTimeoutError < ServerError; end

    # 520..530.
    class CloudflareError < ServerError; end

    attr_reader :config, :client_info, :environment_info

    def initialize(options = {})
      @config = options[:config] || Percy::Config.new
      @client_info = options[:client_info]
      @environment_info = options[:environment_info]
    end
  end
end
