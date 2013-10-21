Rails.application.class.configure do
  config.cache_classes = true
  config.whiny_nils = true if Rails::VERSION::MAJOR < 4
  config.secret_key_base = 'abc123' if Rails::VERSION::MAJOR >= 4
  config.eager_load = false
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false
  config.action_dispatch.show_exceptions = false
  config.active_support.deprecation = :stderr
  config.i18n.enforce_available_locales = true if I18n.respond_to? :enforce_available_locales
end
