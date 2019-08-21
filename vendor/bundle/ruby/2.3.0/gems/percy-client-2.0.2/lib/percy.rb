require 'logger'
require 'percy/client'

module Percy
  def self.config
    @config ||= Percy::Config.new
  end

  def self.reset
    @config = nil
    @client = nil
    @logger = nil
  end

  # API client based on configured options.
  #
  # @return [Percy::Client] API client.
  def self.client(options = {})
    if !defined?(@client) || !@client
      @client = Percy::Client.new(
        config: config,
        client_info: options[:client_info],
        environment_info: options[:environment_info],
      )
    end

    @client
  end

  # @private
  def self.logger
    @logger if defined?(@logger)
    @logger ||= Logger.new(STDOUT)
    @logger.level = config.debug ? Logger::DEBUG : Logger::INFO
    @logger.formatter = proc do |severity, _datetime, _progname, msg|
      "[percy][#{severity}] #{msg}\n"
    end
    @logger
  end

  # @private
  if RUBY_VERSION >= '1.9'
    def self.respond_to_missing?(method_name, include_private = false)
      client.respond_to?(method_name, include_private)
    end
  end

  # @private
  if RUBY_VERSION < '1.9'
    def self.respond_to?(method_name, include_private = false)
      client.respond_to?(method_name, include_private) || super
    end
  end

  # @private
  def self.method_missing(method_name, *args, &block)
    return super unless client.respond_to?(method_name)
    client.send(method_name, *args, &block)
  end
  private :method_missing

  # @private
  def self.respond_to_missing?(method_name, _ = false)
    client.respond_to?(method_name)
  end
end
