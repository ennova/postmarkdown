class PostsController < ApplicationController
  layout lambda { |controller| Postmarkdown::Config.options[:use_theme] ? 'postmarkdown' : 'application' }

  def show
    resource
  end

  def feed
    max_age = 4.hours
    response.headers['Cache-Control'] = 'public, max-age=' + max_age.to_i.to_s
    response.headers['Expires'] = max_age.from_now.httpdate
    response.content_type = 'application/atom+xml'
    fresh_when :last_modified => Post.feed_last_modified
  end

  protected

  def resource
    @resource ||= Post.find(params[:id])
  end
  helper_method :resource

  def collection
    @collection ||= Post.where(params.slice(:year, :month, :day))
  end
  helper_method :collection
end
