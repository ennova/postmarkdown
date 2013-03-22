module Postmarkdown
  module Util
    def self.app_name
      Rails.application.class.name.split('::')[0..-2].join.titleize
    end

    def self.git_config(name)
      value = `git config --get #{name} 2> /dev/null`
      value.chomp if $?.success?
    end
  end
end
