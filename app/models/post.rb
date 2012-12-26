require 'active_record/errors'

class Post
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  include Gravtastic
  is_gravtastic

  attr_reader :slug

  TIME_FORMAT = /-\d{6}/
  DATE_FORMAT = /\d{4}-\d{2}-\d{2}(#{TIME_FORMAT})?/
  SLUG_FORMAT = /[A-Za-z0-9_\-]+/
  EXTENSION_FORMAT = /\.[^.]+/

  FILENAME_FORMAT = /^(#{DATE_FORMAT})-(#{SLUG_FORMAT})(#{EXTENSION_FORMAT})$/

  def initialize(path)
    @path = path
    @date_str, _, @slug = File.basename(path).match(FILENAME_FORMAT).captures
  end

  def to_param
    case permalink_format
    when :day   then "%04d/%02d/%02d/%s" % [year, month, day, slug]
    when :month then "%04d/%02d/%s" % [year, month, slug]
    when :year  then "%04d/%s" % [year, slug]
    when :slug  then slug
    end
  end

  def permalink_format
    Postmarkdown::Config.options[:permalink_format]
  end

  def to_key
    [slug]
  end

  def metadata
    load_content
    @metadata
  end

  def content
    load_content
    @content
  end

  def title
    metadata[:title] || slug.titleize
  end

  def summary
    metadata[:summary]
  end

  def author
    metadata[:author]
  end

  def email
    metadata[:email]
  end

  def date
    @date ||= Time.zone.parse(metadata[:date] || @date_str).to_date
  end

  delegate :year, :month, :day, :to => :date

  def timestamp
    date.to_time_in_current_zone
  end
  alias_method :last_modified, :timestamp

  def visible?
    timestamp <= Time.zone.now
  end

  def to_s
    "#{title.inspect} (#{slug})"
  end

  class << self
    def all
      file_extensions = Postmarkdown::Config.options[:markdown_file_extensions].join(',')
      @@posts ||= Dir.glob("#{directory}/*.{#{file_extensions}}").map do |filename|
        Post.new filename
      end.select(&:visible?).sort_by(&:date).reverse
    end

    def directory
      Rails.root.join('app', 'posts')
    end

    def where(conditions = {})
      conditions = conditions.symbolize_keys
      conditions.assert_valid_keys :year, :month, :day, :slug, :to_param
      [:year, :month, :day].each do |key|
        conditions[key] = conditions[key].to_i if conditions[key].present?
      end
      all.select do |post|
        conditions.all? { |key, value| post.send(key) == value }
      end
    end

    def find(id)
      where(:to_param => id).first or raise ActiveRecord::RecordNotFound, "Could not find post with ID #{id.inspect}"
    end

    def first
      all.first
    end

    def last
      all.last
    end

    def feed
      all.first(10)
    end

    def feed_last_modified
      feed.first.try(:last_modified) || Time.now.utc
    end

    def reset!
      @@posts = nil
    end
  end

  protected

  def load_content
    @content = File.read(@path)
    if @content =~ /^(---\s*\n.*?\n?)^(---\s*$\n?)/m
      @content = @content[($1.size + $2.size)..-1]
      @metadata = YAML.load($1)
    end
    @metadata = (@metadata || {}).with_indifferent_access
  end
end
