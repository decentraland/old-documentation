require 'vcr'

VCR.configure do |c|
  c.configure_rspec_metadata!
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock

  # Uncomment this to get VCR logger debugging.
  # Run: `rspec spec vcr.log` to get debugging output to vcr.log
  # c.debug_logger = File.open(ARGV[1], 'w')

  c.default_cassette_options = {
    record: ENV['RECORD'] ? :new_episodes : :none,
  }

  c.filter_sensitive_data('<FILTERED_PERCY_TOKEN>') do
    ENV['PERCY_TOKEN']
  end
  c.filter_sensitive_data('<COMMIT_AUTHOR_NAME>') do
    `git show --quiet --format="%an"`.strip
  end
  c.filter_sensitive_data('<COMMIT_AUTHOR_EMAIL>') do
    `git show --quiet --format="%ae"`.strip
  end
  c.filter_sensitive_data('<COMMIT_COMMITTER_NAME>') do
    `git show --quiet --format="%cn"`.strip
  end
  c.filter_sensitive_data('<COMMIT_COMMITTER_EMAIL>') do
    `git show --quiet --format="%ce"`.strip
  end
end
