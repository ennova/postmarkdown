ENV['RAILS_ENV'] ||= 'test'

require 'rubygems'
require 'bundler'
Bundler.setup :default, :development

require 'postmarkdown'

require 'rails/version'
if Rails::VERSION::MAJOR == 3 && Rails::VERSION::MINOR == 0
  require 'support/rails_app/config/environment'
else
  require 'combustion'
  Combustion.initialize!
end

require 'capybara/rspec'
require 'rspec/rails'
require 'capybara/rails'

require 'delorean'

RSpec.configure do |config|
  config.mock_with :rspec
  config.include Delorean
end
