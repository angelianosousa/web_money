class CreateReminderJob
  include Sidekiq::Job

  def perform(*args)
    p "Funcionaaaaaaaaaaaaaaaaaaaaaaaa"
  end
end
