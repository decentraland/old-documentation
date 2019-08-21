# -*- encoding: utf-8 -*-
# stub: jekyll-extract-element 0.0.7 ruby lib

Gem::Specification.new do |s|
  s.name = "jekyll-extract-element".freeze
  s.version = "0.0.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Mike Neumegen".freeze]
  s.date = "2017-02-02"
  s.description = "".freeze
  s.email = "mike@cloudcannon.com".freeze
  s.homepage = "http://rubygems.org/gems/jekyll-extract-element".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.5.2.3".freeze
  s.summary = "Extracts a particular element from HTML content".freeze

  s.installed_by_version = "2.5.2.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<jekyll>.freeze, ["~> 3.3"])
      s.add_runtime_dependency(%q<nokogiri>.freeze, ["= 1.8.2"])
    else
      s.add_dependency(%q<jekyll>.freeze, ["~> 3.3"])
      s.add_dependency(%q<nokogiri>.freeze, ["= 1.8.2"])
    end
  else
    s.add_dependency(%q<jekyll>.freeze, ["~> 3.3"])
    s.add_dependency(%q<nokogiri>.freeze, ["= 1.8.2"])
  end
end
