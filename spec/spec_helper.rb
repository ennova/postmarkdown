ENV['RAILS_ENV'] ||= 'test'

require 'rubygems'
require 'bundler'
Bundler.setup :default, :development

require 'postmarkdown'

require 'combustion'
Combustion.initialize! :action_controller, :action_view, :sprockets
require 'active_record/version'

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
