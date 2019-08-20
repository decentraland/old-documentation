RSpec.describe Percy do
  before(:each) { Percy.reset }
  after(:each) { Percy.reset }
  describe '#config' do
    it 'returns a config object' do
      expect(Percy.config.api_url).to eq('http://localhost:3000/api/v1')
    end
  end
  describe '#client' do
    it 'returns a Percy::Client that is passed the global config object by default' do
      config = Percy.config
      expect(Percy.client.config).to eq(config)
    end
  end
  describe '#logger' do
    it 'returns a memoized logger instance' do
      logger = Percy.logger
      expect(logger).to eq(Percy.logger)
      Percy.logger.debug('Test logging that should NOT be output')
      Percy.logger.info('Test logging that SHOULD be output')
      Percy.logger.error('Test logging that SHOULD be output')
      Percy.config.debug = true
      Percy.logger.debug('Test logging that SHOULD be output')
    end
  end
  describe '#reset' do
    it 'clears certain instance variables' do
      old_config = Percy.client.config
      old_client = Percy.client
      old_logger = Percy.logger
      Percy.reset
      expect(old_config).to_not eq(Percy.config)
      expect(old_client).to_not eq(Percy.client)
      expect(old_logger).to_not eq(Percy.logger)
    end
  end
end
