require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RunForrestRun
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    Raven.configure do |config|
      config.dsn = 'https://6d6c5fb990ad4d63a314176ec3415276:fcbae7a7ef944196813f05cfe393a11d@sentry.io/1271393'
    end
  end
end
