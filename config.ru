ENV['BUNDLE_GEMFILE'] = 'gemfiles/rails3_1.gemfile'
# require 'rubygems'
require 'bundler'

Bundler.require :default, :development

Combustion.initialize!
run Combustion::Application
