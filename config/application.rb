require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Depotapp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.middleware.insert_before(Rack::Sendfile, Rack::Deflater)
    config.to_prepare do
      Devise::SessionsController.skip_before_action :authorize
      Devise::RegistrationsController.skip_before_action :authorize
    end
  end
end
