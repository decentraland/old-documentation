RSpec.describe Percy::Config do
  let(:config) { Percy::Config.new }

  it 'returns the correct defaults' do
    expect(config.keys).to eq(
      [
        :access_token,
        :api_url,
        :debug,
        :default_widths,
      ],
    )
    expect(config.access_token).to be_nil
    expect(config.api_url).to eq(ENV['PERCY_API'])
    expect(config.debug).to eq(false)
    expect(config.default_widths).to eq([])
  end
end
