module Postmarkdown
  class PostGenerator < Rails::Generators::Base
    desc File.read(File.expand_path('../usage/post.txt', __FILE__)).gsub('{{CURRENT_DATE}}', Time.zone.now.strftime('%Y-%m-%d'))
    source_root File.expand_path('../templates', __FILE__)
    argument :slug, :type => :string, :required => true
    class_option :date, :type => :string, :group => :runtime, :desc => 'Publish date for the post'

    def check_slug
      unless slug =~ /^#{Post::SLUG_FORMAT}$/
        puts 'Invalid slug - valid characters include letters, digits and dashes.'
        exit
      end
    end

    def check_date
      if options.date && options.date !~ /^#{Post::DATE_FORMAT}$/
        puts 'Invalid date - please use the following format: YYYY-MM-DD, eg. 2011-01-01.'
        exit
      end
    end

    def generate_post
      template 'example-post.markdown', "app/posts/#{publish_date}-#{slug.downcase}.markdown"
    end

    private

    def publish_date
      format = '%Y-%m-%d-%H%M%S'

      if options.date.present?
        date_string = options.date
        date_string += '-000000' unless options.date.match(/(#{Post::TIME_FORMAT}$)/)
        date = DateTime.strptime(date_string, format)
      else
        date = Time.zone.now
      end

      date.strftime(format)
    end
  end
end
