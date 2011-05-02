ENV['RAILS_ENV'] ||= 'test'
require 'support/rails_app/config/environment'
require 'rspec/rails'
require 'capybara/rspec'
require 'delorean'

Dir[Rails.root.join('spec/support/**/*.rb')].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec
  config.include Delorean
end
