# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "kindle/version"

Gem::Specification.new do |s|
  s.name        = "kindle"
  s.version     = Kindle::VERSION
  s.authors     = ["Matt Petty"]
  s.email       = ["matt@kizmeta.com", "lodestone@gmail.com"]
  s.homepage    = ""
  s.summary     = Kindle::SUMMARY 
  s.description = Kindle::DESCRIPTION 

  s.rubyforge_project = "kindle"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
  s.add_runtime_dependency 'nokogiri'
  s.add_runtime_dependency 'mechanize'
  s.add_runtime_dependency 'highline'
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_development_dependency('rake','~> 0.9.2')
  s.add_dependency('methadone')
end
