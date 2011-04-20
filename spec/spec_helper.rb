ENV['RAILS_ENV'] ||= 'test'
require 'support/rails_app/config/environment'

Dir[Rails.root.join('spec/support/**/*.rb')].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec
end
