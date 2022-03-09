Sidekiq.configure_client do |config|
  config.redis = { db: 1 }
end

Sidekiq.configure_server do |config|
  config.redis = { db: 1 }
  config.periodic do |job|
    job.register('* * * * * *', "CreateReminder", tz: ActiveSupport::TimeZone.new("America/Fortaleza"))
  end
end
