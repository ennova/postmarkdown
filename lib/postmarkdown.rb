module Postmarkdown
  if defined?(Rails)
    require 'postmarkdown/engine'
    require 'postmarkdown/config'
    require 'postmarkdown/routes'
  end
end
