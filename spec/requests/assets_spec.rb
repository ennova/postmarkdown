require 'spec_helper'

describe 'stylesheet', :type => :request do
  it 'should be served' do
    visit '/stylesheets/postmarkdown/postmarkdown.css'
    page.source.should match /font-family:/
    page.source.should match /}\s*\z/
  end
end
