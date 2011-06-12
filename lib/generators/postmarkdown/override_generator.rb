module Postmarkdown
  class OverrideGenerator < Rails::Generators::Base
    desc File.read(File.expand_path('../usage/override.txt', __FILE__))
    source_root File.expand_path('../../../../app', __FILE__)

    class_option :all,        :type => :boolean, :group => :override, :desc => 'Override all of the things'
    class_option :views,      :type => :boolean, :group => :override, :desc => 'Override the Post views'
    class_option :model,      :type => :boolean, :group => :override, :desc => 'Override the Post model'
    class_option :controller, :type => :boolean, :group => :override, :desc => 'Override the Posts controller'
    class_option :theme,      :type => :boolean, :group => :override, :desc => 'Override the layout and stylesheet'

    def check_class_options
      if options.blank?
        exec 'rails g postmarkdown:override --help'
        exit
      end
    end

    def override_views
      if options.views || options.all
        directory 'views/posts', 'app/views/posts'
      end
    end

    def override_model
      if options.model || options.all
        copy_file 'models/post.rb', 'app/models/post.rb'
      end
    end

    def override_controller
      if options.controller || options.all
        copy_file 'controllers/posts_controller.rb', 'app/controllers/posts_controller.rb'
      end
    end

    def override_theme
      if options.theme || options.all
        directory 'views/layouts', 'views/layouts'
        directory '../public/stylesheets', 'public/stylesheets'
      end
    end
  end
end
