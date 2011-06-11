module Postmarkdown
  if defined?(Rails)
    require 'postmarkdown/engine'
    require 'postmarkdown/config'
    require 'postmarkdown/routes'
    require 'postmarkdown/util'
  end
end
