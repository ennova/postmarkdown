xml.instruct!
xml.feed :xmlns => 'http://www.w3.org/2005/Atom' do
  xml.title Postmarkdown::Config.options[:feed_title]
  xml.link :href => posts_feed_url, :rel => :self, :type => 'application/atom+xml'
  xml.link :href => posts_url, :rel => :alternate, :type => 'text/html'
  xml.id posts_url
  xml.updated Post.feed_last_modified.xmlschema

  Post.feed.each do |post|
    xml.entry do
      xml.title post.title, :type => :text
      xml.link :href => post_url(post), :rel => :alternate, :type => 'text/html'
      xml.published post.timestamp.xmlschema
      xml.updated post.last_modified.xmlschema

      if post.author.present?
        xml.author do
          xml.name post.author
          xml.email post.email if post.email.present?
        end
      end

      xml.id post_url(post)
      xml.content :type => :html, 'xml:base' => post_url(post) do
        xml.cdata! post.content_html
      end
    end
  end
end
