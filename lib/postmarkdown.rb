module Postmarkdown
  if defined?(Rails)
    require 'postmarkdown/engine'
    require 'postmarkdown/routes'
  end
end
