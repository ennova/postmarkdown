require 'rouge/plugins/redcarpet'

module Postmarkdown
  class MarkdownRenderer
    class HTMLWithRouge < Redcarpet::Render::HTML
      include Rouge::Plugins::Redcarpet
    end

    def initialize
      @markdown = ::Redcarpet::Markdown.new(HTMLWithRouge, :fenced_code_blocks => true)
    end

    def render(text)
      @markdown.render(text)
    end
  end
end
