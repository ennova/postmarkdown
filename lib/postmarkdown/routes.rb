class ActionDispatch::Routing::Mapper
  def postmarkdown(options = {})
    options.reverse_merge!({ :as => :posts })
    get "/#{options[:as]}(/:year(/:month(/:day)))" => 'posts#index', :as => :posts, :constraints => { :year => /\d{4}/, :month => /\d{2}/, :day => /\d{2}/}
    get "/#{options[:as]}/*id" => 'posts#show', :as => :post, :constraints => { :id => %r[\d{4}/\d{2}/\d{2}/[^/]+] }
    get "/#{options[:as]}/feed" => 'posts#feed', :as => :posts_feed, :format => :xml
  end
end
