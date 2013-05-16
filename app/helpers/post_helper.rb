module PostHelper
  class Sanitizer < HTML::WhiteListSanitizer
    self.allowed_tags.merge(%w(img a))
  end

  def post_summary_html(post)
    if post.summary.present?
      content_tag :p, post.summary
    else
      reg = /<!--more-->/
      html = post_content_html(post)

      html = html[0..(html =~ reg)-1]
      doc = Nokogiri::HTML.fragment(html)
      doc.try(:to_html).try(:html_safe)
    end
  end

  def post_content_html(post)
    RDiscount.new(render(:inline => post.content)).to_html.html_safe
  end
end
