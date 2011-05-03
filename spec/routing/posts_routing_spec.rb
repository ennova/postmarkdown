require 'spec_helper'

describe PostsController do
  describe 'default routes' do
    it '/posts to Posts#index' do
      path = posts_path
      path.should == '/posts'
      { :get => path }.should route_to :controller => 'posts', :action => 'index'
    end

    it '/posts/2012 to Posts#index with year' do
      path = posts_path(:year => '2012')
      path.should == '/posts/2012'
      { :get => path }.should route_to :controller => 'posts', :action => 'index', :year => '2012'
    end

    it '/posts/2012/01 to Posts#index with year and month' do
      path = posts_path(:year => '2012', :month => '01')
      path.should == '/posts/2012/01'
      { :get => path }.should route_to :controller => 'posts', :action => 'index', :year => '2012', :month => '01'
    end

    it '/posts/2012/01/01 to Posts#index with year, month and day' do
      path = posts_path(:year => '2012', :month => '01', :day => '01')
      path.should == '/posts/2012/01/01'
      { :get => path }.should route_to :controller => 'posts', :action => 'index', :year => '2012', :month => '01', :day => '01'
    end

    it '/posts/2012/01/01/test-post to Posts#show with permalink a format of day' do
      path = post_path(:id => '2012/01/01/test-post')
      path.should == '/posts/2012/01/01/test-post'
      { :get => path }.should route_to :controller => 'posts', :action => 'show', :id => '2012/01/01/test-post'
    end
  end

  describe 'custom routes' do
    before { Rails.application.routes.clear! }
    after { Rails.application.reload_routes! }

    it '/blog to Posts#index' do
      Rails.application.routes.draw { postmarkdown :as => :blog }

      path = posts_path
      path.should == '/blog'
      { :get => path }.should route_to :controller => 'posts', :action => 'index'
    end

    it '/blog/test-post to Posts#show with a permalink format of slug' do
      Rails.application.routes.draw { postmarkdown :as => :blog, :permalink_format => :slug }

      path = post_path(:id => 'test-post')
      path.should == '/blog/test-post'
      { :get => path }.should route_to :controller => 'posts', :action => 'show', :id => 'test-post'
    end

    it '/blog/2012/test-post to Posts#show with a permalink format of year' do
      Rails.application.routes.draw { postmarkdown :as => :blog, :permalink_format => :year }

      path = post_path(:id => '2012/test-post')
      path.should == '/blog/2012/test-post'
      { :get => path }.should route_to :controller => 'posts', :action => 'show', :id => '2012/test-post'
    end

    it '/blog/2012/01/test-post to Posts#show with permalink a format of month' do
      Rails.application.routes.draw { postmarkdown :as => :blog, :permalink_format => :month }

      path = post_path(:id => '2012/01/test-post')
      path.should == '/blog/2012/01/test-post'
      { :get => path }.should route_to :controller => 'posts', :action => 'show', :id => '2012/01/test-post'
    end

    it '/blog/2012/01/01/test-post to Posts#show with permalink a format of day' do
      Rails.application.routes.draw { postmarkdown :as => :blog, :permalink_format => :day }

      path = post_path(:id => '2012/01/01/test-post')
      path.should == '/blog/2012/01/01/test-post'
      { :get => path }.should route_to :controller => 'posts', :action => 'show', :id => '2012/01/01/test-post'
    end
  end
end
