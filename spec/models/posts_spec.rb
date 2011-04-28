require 'spec_helper'

describe Post do
  def test_post(name)
    Post.new(File.dirname(__FILE__) + "/../support/data/posts/#{name}.markdown")
  end

  it "should not initialise with bad filename" do
    lambda { test_post 'missing-date-from-filename.markdown' }.should raise_error
  end

  context "with missing file" do
    subject { test_post '2000-01-01-no-such-file.markdown' }
    it "should error when trying to read content" do
      lambda { subject.content }.should raise_error
    end
  end

  context "with first post" do
    subject { test_post '2011-04-01-first-post' }
    its(:slug) { should == 'first-post' }
    its(:date) { should == Date.parse('2011-04-01') }
    its(:title) { should == 'First Post' }
    its(:content) { should =~ /\ALorem ipsum/ }
    its(:content_html) { should =~ /^<p>Lorem ipsum/ }
    its(:content_html) { should =~ /^<p>Duis aute irure dolor/ }
    its(:content_html) { should be_html_safe }
    its(:summary_html) { should =~ /^<p>Lorem ipsum/ }
    its(:summary_html) { should_not =~ /^<p>Duis aute irure dolor/ }
    its(:summary_html) { should be_html_safe }
  end

  context "with custom title post" do
    subject { test_post '2015-02-13-custom-title' }
    its(:slug) { should == 'custom-title' }
    its(:date) { should == Date.parse('2015-02-13') }
    its(:title) { should == 'This is a custom title' }
    its(:content) { should == "Content goes here.\n" }
  end

  context "with image post" do
    subject { test_post '2011-04-28-image' }
    its(:summary_html) { should =~ /^<p>Image description/ }
    its(:summary_html) { should be_html_safe }
  end

  context "with custom summary post" do
    subject { test_post '2011-04-28-summary' }
    its(:summary_html) { should == '<p>This is a custom &amp; test summary.</p>' }
    its(:summary_html) { should be_html_safe }
  end
end
