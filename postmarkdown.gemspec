# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'postmarkdown/version'

Gem::Specification.new do |s|
  s.name        = 'postmarkdown'
  s.version     = Postmarkdown::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Jason Weathered', 'Nathanael Kane', 'Lucas Willet', 'Odin Dutton']
  s.email       = ['jason.weathered@ennova.com.au', 'nate.kane@ennova.com.au', 'lucas.willett@ennova.com.au', 'odin.dutton@ennova.com.au']
  s.licenses    = ['MIT']

  s.homepage    = ''
  s.summary     = %q{A simple Rails blog engine powered by markdown.}
  s.description = s.summary

  s.rubyforge_project = 'postmarkdown'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency 'rails', '3.0.6'
  s.add_dependency 'haml', '3.1.0.alpha.147'
  s.add_dependency 'gravtastic'
  s.add_dependency 'nokogiri'
  s.add_dependency 'rdiscount'

  s.add_development_dependency 'rspec-rails', '2.5.0'
end
