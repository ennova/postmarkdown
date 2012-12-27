require 'spec_helper'

describe Post do
  def test_post(file_name)
    Post.new(File.dirname(__FILE__) + "/../support/data/posts/#{file_name}")
  end

  it 'should not initialise with bad filename' do
    lambda { test_post 'missing-date-from-filename.markdown' }.should raise_error
  end

  context 'with missing file' do
    subject { test_post '2000-01-01-no-such-file.markdown' }
    it 'should error when trying to read content' do
      lambda { subject.content }.should raise_error
    end
  end

  it 'should return the correct directory' do
    Post.directory.should == Rails.root.join('app', 'posts')
  end

  context 'with first post' do
    subject { test_post '2011-04-01-first-post.markdown' }
    its(:slug) { should == 'first-post' }
    its(:date) { should == Date.parse('2011-04-01') }
    its(:title) { should == 'First Post' }
    its(:content) { should =~ /\ALorem ipsum/ }
  end

  context 'with custom title post' do
    subject { test_post '2015-02-13-custom-title.markdown' }
    its(:slug) { should == 'custom-title' }
    its(:date) { should == Date.parse('2015-02-13') }
    its(:title) { should == 'This is a custom title' }
    its(:content) { should == "Content goes here.\n" }
  end

  context 'with a custom title that also and including timestamp' do
    subject { test_post '2012-02-13-102030-custom-title-and-timestamp.markdown' }
    its(:slug) { should == 'custom-title-and-timestamp' }
    its(:date) { should == Time.utc(2012, 02, 13, 10, 20, 30).to_date }
    its(:title) { should == 'This is a custom title' }
    its(:content) { should == "Content goes here.\n" }
  end

  context 'with a slug containing underscores' do
    subject { test_post '2012-02-12-102030-slug_containing_underscores.markdown' }
    its(:slug) { should == 'slug_containing_underscores' }
  end

  context 'with author' do
    subject { test_post '2011-05-01-full-metadata.markdown' }
    its(:author) { should == 'John Smith' }
    its(:email) { should == 'john.smith@example.com' }
  end

  context 'with custom summary post' do
    subject { test_post '2011-04-28-summary.markdown' }
    its(:summary) { should == 'This is a custom & test summary.' }
  end

  context 'with alternate markdown file extension' do
    it 'should accept *.md files' do
      lambda { test_post('2011-05-02-md-file-extension.md').content }.should_not raise_error
    end

    it 'should accept *.mkd files' do
      lambda { test_post('2011-05-02-mkd-file-extension.mkd').content }.should_not raise_error
    end

    it 'should accept *.mdown files' do
      lambda { test_post('2011-05-02-mdown-file-extension.mdown').content }.should_not raise_error
    end
  end
end
