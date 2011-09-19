module Postmarkdown
  class Railtie < Rails::Railtie
    initializer :before_initialize do
      ActionController::Base.append_view_path("#{postmarkdown_root}/app/views")
    end

    private

    def postmarkdown_root
      File.expand_path(File.dirname(__FILE__) + '/../..')
    end
  end
end
