require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Leaderboard
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.active_record.observers = [:user_observer, :email_observer, :organization_observer]

    config.railties_order = [ :all, ComfortableMexicanSofa::Engine ]

    config.autoload_paths << Rails.root.join('lib')

    config.paperclip_defaults = {
      :storage => :fog,
      fog_credentials: {
        provider: 'Google',
        google_storage_access_key_id: ENV['GOOGLE_ACCESS_KEY'],
        google_storage_secret_access_key: ENV['GOOGLE_SECRET_KEY']
      },
      fog_directory: ENV['GOOGLE_DIRECTORY'],
      fog_public: true
    }
    config.middleware.delete Rack::Lock if Rails.env.development?
  end
end
