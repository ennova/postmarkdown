require 'spec_helper'

module Postmarkdown
  describe PostGenerator do
    include GeneratorSpec::TestCase
    destination File.expand_path('../../../../../tmp', __FILE__)

    before do
      prepare_destination

      Post.stub(:directory) { File.expand_path('tmp/app/posts') }
      Post.class_variable_set('@@posts', nil)
    end

    context 'with the slug parameter' do
      it 'creates a file for the slug and the current date' do
        Timecop.freeze(Time.utc(2012, 1, 1, 10, 20, 30)) do
          run_generator %w(test-post)

          Dir.glob('tmp/app/posts/*').should == ['tmp/app/posts/2012-01-01-102030-test-post.markdown']

          Post.all.count.should == 1

          post = Post.first
          post.slug.should == 'test-post'
          post.date.should == Date.parse('2012-01-01')
          post.title.should == 'Test post'
        end
      end
    end

    context 'with the slug parameter including an underscore' do
      it 'creates the correct file and sets the right values' do
        Timecop.freeze(Time.utc(2012, 1, 1, 10, 20, 30)) do
          run_generator %w(test-post_with_underscores)

          Dir.glob('tmp/app/posts/*').should == ['tmp/app/posts/2012-01-01-102030-test-post_with_underscores.markdown']

          Post.all.count.should == 1

          post = Post.first
          post.slug.should == 'test-post_with_underscores'
          post.date.should == Date.parse('2012-01-01')
          post.title.should == 'Test post_with_underscores'
        end
      end
    end

    context 'with the slug and date parameters' do
      it 'creates a file for the slug and the given date' do
        run_generator %w(other-post --date=2012-01-02)

        Dir.glob('tmp/app/posts/*').should == ['tmp/app/posts/2012-01-02-000000-other-post.markdown']

        Post.all.count.should == 1

        post = Post.first
        post.slug.should == 'other-post'
        post.date.should == Date.parse('2012-01-02')
        post.title.should == 'Other post'
      end
    end

    context 'with the slug, date and time parameters' do
      it 'creates a file for the slug and the given date' do
        run_generator %w(other-post --date=2012-01-02-102030)

        Dir.glob('tmp/app/posts/*').should == ['tmp/app/posts/2012-01-02-102030-other-post.markdown']

        Post.all.count.should == 1

        post = Post.first
        post.slug.should == 'other-post'
        post.date.should == Time.utc(2012, 01, 02, 10, 20, 30).to_date
        post.title.should == 'Other post'
      end
    end

    context 'with invalid slug' do
      it 'raises a system exit exception' do
        lambda { run_generator %w(!test-post) }.should raise_error(SystemExit)
      end

      it 'does not create the file' do
        Dir['app/posts/*'].should be_empty
      end
    end

    context 'with invalid date' do
      it 'raises a system exit exception' do
        lambda { run_generator %w(test-post --date=2012-02) }.should raise_error(SystemExit)
      end

      it 'does not create the file' do
        Dir['app/posts/*'].should be_empty
      end
    end
  end
end
