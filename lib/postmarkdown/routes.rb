class ActionDispatch::Routing::Mapper
  require 'postmarkdown/util'

  def postmarkdown(options = {})
    options.reverse_merge!({ :as => :posts, :permalink_format => :day })

    get "/#{options[:as]}(/:year(/:month(/:day)))" => 'posts#index', :as => :posts, :constraints => { :year => /\d{4}/, :month => /\d{2}/, :day => /\d{2}/}
    get "/#{options[:as]}/feed" => 'posts#feed', :as => :posts_feed, :defaults => { :format => :xml }
    get "/#{options[:as]}/*id" => 'posts#show', :as => :post, :constraints => { :id => postmarkdown_permalink_regex(options) }

    postmarkdown_feed_title(options[:as])
  end

  private

  def postmarkdown_permalink_regex(options)
    Postmarkdown::Config.options[:permalink_format] = options[:permalink_format]
    Postmarkdown::Config.options[:permalink_regex].try(:[], options[:permalink_format]) or raise_postmarkdown_permalink_error
  end

  def postmarkdown_feed_title(path)
    Postmarkdown::Config.options[:feed_title] ||= "#{Postmarkdown::Util.app_name} #{path.to_s.tr('/', '_').humanize.titleize}"
  end

  def raise_postmarkdown_permalink_error
    possible_options = Postmarkdown::Config.options[:permalink_regex].map { |k,v| k.inspect }.join(', ')
    raise "Postmarkdown Routing Error: Invalid :permalink_format option #{Postmarkdown::Config.options[:permalink_format].inspect} - must be one of the following: #{possible_options}"
  end
end
