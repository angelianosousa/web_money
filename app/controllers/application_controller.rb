class ApplicationController < ActionController::Base
  add_flash_types :notice, :alert, :warning
  before_action :authenticate_user!

  layout :layout_by_resource

  helper_method :current_profile

  def layout_by_resource
    devise_controller? ? "#{resource_class.to_s.downcase}_devise" : "application"
  end

  def current_profile
    current_user.try(:user_profile)
  end

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
end
