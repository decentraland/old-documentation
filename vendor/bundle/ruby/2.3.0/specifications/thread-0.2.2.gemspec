# -*- encoding: utf-8 -*-
# stub: thread 0.2.2 ruby lib

Gem::Specification.new do |s|
  s.name = "thread".freeze
  s.version = "0.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["meh.".freeze]
  s.date = "2015-07-17"
  s.description = "Includes a thread pool, message passing capabilities, a recursive mutex, promise, future and delay.".freeze
  s.email = ["meh@schizofreni.co".freeze]
  s.homepage = "http://github.com/meh/ruby-thread".freeze
  s.licenses = ["WTFPL".freeze]
  s.rubygems_version = "2.5.2.3".freeze
  s.summary = "Various extensions to the base thread library.".freeze

  s.installed_by_version = "2.5.2.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
