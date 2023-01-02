class CreateReminderJob

  def perform
    number_of_notifications = 0

    Bill.all.each do |bill|
      if bill.date <= Date.today
        Notification.create(title: "#{bill.title} - Vence hoje!")
        number_of_notifications += 1
      end
    end
    
    p "Notificações criadas #{number_of_notifications} - #{Date.today}"
  end
end
