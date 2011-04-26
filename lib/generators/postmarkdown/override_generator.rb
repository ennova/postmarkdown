module Postmarkdown
  class OverrideGenerator < Rails::Generators::Base
    desc File.read(File.expand_path('../usage/override.txt', __FILE__))
    source_root File.expand_path('../../../../app', __FILE__)

    class_option :view,       :type => :string,  :group => :override, :desc => 'Override a Posts view'
    class_option :model,      :type => :boolean, :group => :override, :desc => 'Override the Post model'
    class_option :controller, :type => :boolean, :group => :override, :desc => 'Override the Posts controller'

    def check_class_options
      if options.view.blank? && options.model.blank? && options.controller.blank?
        exec 'rails g postmarkdown:override --help'
        exit
      end
    end

    def override_view
      if options.view
        copy_file "views/posts/#{options.view}", "app/views/posts/#{options.view}"
      end
    end

    def override_model
      if options.model
        copy_file 'models/post.rb', 'app/models/post.rb'
      end
    end

    def override_controller
      if options.controller
        copy_file 'controllers/posts_controller.rb', 'app/controllers/posts_controller.rb'
      end
    end
  end
end
