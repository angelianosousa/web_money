# frozen_string_literal: true

# Notifications Routes Controller
class NotificationsController < ApplicationController
  def index
    @notifications_read = Notification.read(current_user.user_profile.id).page(params[:page])
    @notifications_unread = Notification.unread(current_user.user_profile.id).page(params[:page])
  end

  def mark_as_read
    @notification = Notification.find(params[:id])
    @notification.update(read: true)
    redirect_to notifications_path, notice: 'Mensagem marcada como lida'
  end
end
