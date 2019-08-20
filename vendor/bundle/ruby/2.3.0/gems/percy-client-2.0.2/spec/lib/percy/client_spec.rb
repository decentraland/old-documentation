RSpec.describe Percy::Client do
  describe 'config' do
    it 'returns the config object given when initialized' do
      config = Percy::Config.new
      client = Percy::Client.new(config: config)
      expect(client.config).to eq(config)
    end
  end
end
