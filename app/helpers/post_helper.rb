module PostHelper
  class Sanitizer < HTML::WhiteListSanitizer
    self.allowed_tags.merge(%w(img a))
  end

  def post_summary_html(post)
    if post.summary.present?
      content_tag :p, post.summary
    else
      reg = /<!--more-->/
      html_text = post_content_html(post)

      html = !((html_text =~ reg).nil?) ? html_text[0..(html_text =~ reg)-1] : html_text
      doc = Nokogiri::HTML.fragment(html)
      doc = doc.search('p').detect { |p| p.text.present? } if (html_text =~ reg).nil?
      doc.try(:to_html).try(:html_safe)
    end
  end

  def post_content_html(post)
    RDiscount.new(render(:inline => post.content)).to_html.html_safe
  end
end
