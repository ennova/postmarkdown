require 'spec_helper'

describe 'views', :type => :request do
  context 'without application index view' do
    it 'should use internal view' do
      visit '/posts'
      page.should have_css 'section#posts'
      page.should_not have_content 'test application view'
    end
  end

  context 'with application index view' do
    let(:view_path) { Rails.root + 'app/views/posts/index.html.haml' }

    before do
      ApplicationController.view_paths.each(&:clear_cache)
      FileUtils.mkdir_p File.dirname(view_path)
      File.open view_path, 'w' do |io|
        io.puts 'This is a test application view.'
      end
    end

    after do
      File.unlink view_path
      ApplicationController.view_paths.each(&:clear_cache)
    end

    it 'should not use internal view' do
      visit '/posts'
      page.should have_content 'test application view'
      page.should_not have_css 'section#posts'
    end
  end
end
