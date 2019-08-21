# -*- encoding: utf-8 -*-
# stub: percy-cli 1.4.0 ruby lib

Gem::Specification.new do |s|
  s.name = "percy-cli".freeze
  s.version = "1.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Perceptual Inc.".freeze]
  s.date = "2018-09-15"
  s.description = "".freeze
  s.email = ["team@percy.io".freeze]
  s.executables = ["percy".freeze]
  s.files = ["bin/percy".freeze]
  s.homepage = "".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.5.2.3".freeze
  s.summary = "Percy command-line interface".freeze

  s.installed_by_version = "2.5.2.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<commander>.freeze, ["~> 4.3"])
      s.add_runtime_dependency(%q<percy-client>.freeze, ["~> 2.0"])
      s.add_runtime_dependency(%q<thread>.freeze, ["~> 0.2"])
      s.add_runtime_dependency(%q<addressable>.freeze, ["~> 2"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.7"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3"])
      s.add_development_dependency(%q<webmock>.freeze, ["~> 1"])
      s.add_development_dependency(%q<percy-style>.freeze, [">= 0"])
    else
      s.add_dependency(%q<commander>.freeze, ["~> 4.3"])
      s.add_dependency(%q<percy-client>.freeze, ["~> 2.0"])
      s.add_dependency(%q<thread>.freeze, ["~> 0.2"])
      s.add_dependency(%q<addressable>.freeze, ["~> 2"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.7"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3"])
      s.add_dependency(%q<webmock>.freeze, ["~> 1"])
      s.add_dependency(%q<percy-style>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<commander>.freeze, ["~> 4.3"])
    s.add_dependency(%q<percy-client>.freeze, ["~> 2.0"])
    s.add_dependency(%q<thread>.freeze, ["~> 0.2"])
    s.add_dependency(%q<addressable>.freeze, ["~> 2"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.7"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3"])
    s.add_dependency(%q<webmock>.freeze, ["~> 1"])
    s.add_dependency(%q<percy-style>.freeze, [">= 0"])
  end
end
