module Postmarkdown
  module Util
    def self.git_config(name)
      value = `git config --get #{name}`.chomp
      value if $?.success?
    end
  end
end
