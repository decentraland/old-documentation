# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'percy/cli/version'

Gem::Specification.new do |spec|
  spec.name          = 'percy-cli'
  spec.version       = Percy::Cli::VERSION
  spec.authors       = ['Perceptual Inc.']
  spec.email         = ['team@percy.io']
  spec.summary       = %q{Percy command-line interface}
  spec.description   = %q{}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'commander', '~> 4.3'
  spec.add_dependency 'percy-client', '~> 2.0'
  spec.add_dependency 'thread', '~> 0.2'
  spec.add_dependency 'addressable', '~> 2'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3'
  spec.add_development_dependency 'webmock', '~> 1'
  spec.add_development_dependency 'percy-style'
end
