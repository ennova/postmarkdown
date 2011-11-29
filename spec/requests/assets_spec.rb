require 'spec_helper'

describe 'stylesheet', :type => :request do
  include RSpec::Rails::HelperExampleGroup

  def stylesheet_path
    html = helper.stylesheet_link_tag 'postmarkdown/postmarkdown'
    Nokogiri::HTML.fragment(html).at('link')[:href]
  end

  it 'should be served' do
    visit stylesheet_path
    page.source.should match /font-family:/
    page.source.should match /}\s*\z/
  end
end
