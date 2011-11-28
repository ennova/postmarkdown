module Postmarkdown
  class Railtie < Rails::Railtie
    initializer :before_initialize do
      unless Rails.application.config.respond_to?(:assets) && Rails.application.config.assets.enabled
        puts 'hai'
        require 'rack'
        Rails.configuration.middleware.insert_before('Rack::Sendfile', 'Rack::Static',
          :urls => ['/stylesheets/postmarkdown'],
          :root => "#{postmarkdown_root}/vendor/assets"
        )
      end
      ActionController::Base.append_view_path("#{postmarkdown_root}/app/views")
    end

    private

    def postmarkdown_root
      File.expand_path(File.dirname(__FILE__) + '/../..')
    end
  end
end
