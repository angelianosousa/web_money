class CreateReminderJob
  include Sidekiq::Job
  def perform
    number_of_notifications = 0

    Recurrence.all.each do |recurrence|
      if recurrence.date_expire == Date.today
        Notification.create(recurrence: recurrence, title: "#{recurrence.title} - Vence hoje!")
        number_of_notifications += 1
      end
    end
    
    p "Notificações criadas #{number_of_notifications} - #{Date.today}"
  end
end
