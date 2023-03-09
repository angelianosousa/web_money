if Rails.env.production?
  Rails.application.config.hosts = ENV.fetch('SITE_DOMAIN') { 'localhost' }
end