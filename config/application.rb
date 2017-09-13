require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Push
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.time_zone = 'Seoul'
    config.i18n.default_locale = :ko
    config.i18n.fallbacks = true
    I18n.enforce_available_locales=true
    I18n.available_locales = [:ko, :en, :'zh-CN']
    config.assets.paths << Rails.root.join("app", "assets", "fonts")    
  end
end
