module Postmarkdown
  class InstallGenerator < Rails::Generators::Base
    desc File.read(File.expand_path('../usage/install.txt', __FILE__)).gsub('{{CURRENT_DATE}}', Time.zone.now.strftime('%Y-%m-%d'))
    source_root File.expand_path('../templates', __FILE__)
    class_option :skip_example, :type => :boolean, :group => :runtime, :desc => 'Skip generating an example post'

    def create_directory
      empty_directory 'app/posts'
    end

    def generate_example_post
      generate 'postmarkdown:post', 'example-post' unless options.skip_example?
    end

    def add_routes
      insert_into_file 'config/routes.rb', "  postmarkdown :as => :posts\n\n", :after => "::Application.routes.draw do\n"
    end
  end
end
