require 'spec_helper'

describe PostHelper do
  def test_post(file_name)
    Post.new(File.dirname(__FILE__) + "/../support/data/posts/#{file_name}")
  end

  let(:summary_html) { helper.post_summary_html(post) }
  let(:content_html) { helper.post_content_html(post) }

  context 'with first post' do
    let(:post) { test_post '2011-04-01-first-post.markdown' }

    it 'renders HTML content' do
      content_html.should be_html_safe
      content_html.should =~ /^<p>Lorem ipsum/
      content_html.should =~ /^<p>Duis aute irure dolor/
    end

    it 'renders HTML summary' do
      summary_html.should be_html_safe
      summary_html.should =~ /^<p>Lorem ipsum/
      summary_html.should_not =~ /^<p>Duis aute irure dolor/
    end
  end

  context 'with image post' do
    let(:post) { test_post '2011-04-28-image.markdown' }

    it 'renders HTML summary' do
      summary_html.should be_html_safe
      summary_html.should =~ /^<p><img src=\"example.png\">/
    end

    it 'renders HTML content' do
      content_html.should be_html_safe
      content_html.should =~ /^<p><img src="example.png" \/>/
    end
  end

  context 'with custom summary post' do
    let(:post) { test_post '2011-04-28-summary.markdown' }

    it 'renders HTML summary' do
      summary_html.should be_html_safe
      summary_html.should eq '<p>This is a custom &amp; test summary.</p>'
    end
  end
end
