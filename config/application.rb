require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FinancesSystem
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.i18n.available_locales = [:en, :'pt-BR']
    config.i18n.default_locale = :'pt-BR'
    # config.active_job.queue_adapter = :good_job
    config.hosts = [
      IPAddr.new("0.0.0.0/0"), # All IPv4 addresses.
      IPAddr.new("::/0"),      # All IPv6 addresses.
      "localhost",             # The localhost reserved domain.
      "financessystem-angelianosousa.b4a.run"   # Allow this to be addressed when running in containers via docker-compose.yml.
    ]
  end
end
