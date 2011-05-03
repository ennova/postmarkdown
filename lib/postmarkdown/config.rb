module Postmarkdown
  module Config
    extend self

    @options = {}
    attr_accessor :options
  end
end

Postmarkdown::Config.options[:feed_title] = nil

Postmarkdown::Config.options[:permalink_format] = :day

Postmarkdown::Config.options[:permalink_regex] = {}
Postmarkdown::Config.options[:permalink_regex][:day]   = %r[\d{4}/\d{2}/\d{2}/[^/]+]
Postmarkdown::Config.options[:permalink_regex][:month] = %r[\d{4}/\d{2}/[^/]+]
Postmarkdown::Config.options[:permalink_regex][:year]  = %r[\d{4}/[^/]+]
Postmarkdown::Config.options[:permalink_regex][:slug]  = %r[[^/]+]

Postmarkdown::Config.options[:markdown_file_extensions] = %w(md mkd mdown markdown)
