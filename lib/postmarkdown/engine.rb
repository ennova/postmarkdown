module Postmarkdown
  require 'postmarkdown'
  require 'rails'
  require 'gravtastic'
  require 'rdiscount'
  require 'nokogiri'
  require 'haml'

  class Engine < Rails::Engine
    initializer 'postmarkdown.config_options' do |app|
      Postmarkdown::Config.options[:feed_title] ||= Rails.application.class.name.split("::")[0..-2].join.titleize
    end
  end
end
