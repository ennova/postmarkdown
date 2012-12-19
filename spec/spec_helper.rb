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

require 'timecop'
require 'generator_spec/test_case'
Dir[File.expand_path('lib/generators/postmarkdown/*.rb')].each { |f| require f }

require 'delorean'

RSpec.configure do |config|
  config.mock_with :rspec
  config.include Delorean
  config.order = :random

  config.after do
    Timecop.return
    FileUtils.rm_rf('spec/tmp/app/posts/.')
  end
end

ActiveSupport::Deprecation.debug = true
