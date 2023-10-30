# frozen_string_literal: true

# Base Application Entity Controller
class ApplicationController < ActionController::Base
  add_flash_types :success, :danger, :warning
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_active_storage_host

  layout :layout_by_resource

  def layout_by_resource
    if controller_name == 'registrations' && (action_name == 'edit' || action_name == 'update')
      'application'
    elsif devise_controller?
      'user_devise'
    else
      'application'
    end
  end

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  # CREATE
  def handle_successful_creation(format, to_path, resource)
    format.html { redirect_to to_path, flash: { success: t('.success') } }
    format.js   { flash.now[:success] = t('.success') }
    format.json { render :show, status: :created, location: resource }
  end

  def handle_failed_creation(format, to_path, resource)
    format.html { redirect_to to_path, flash: { danger: resource.errors.full_messages } }
    format.js   { flash.now[:danger] = resource.errors.full_messages }
    format.json { render json: resource.errors, status: :unprocessable_entity }
  end

  # UPDATE
  def handle_successful_update(format, to_path, resource)
    format.html { redirect_to to_path, flash: { success: t('.success') } }
    format.json { render :show, status: :ok, location: resource }
  end

  def handle_failed_update(format, to_path, resource)
    format.html { redirect_to to_path, flash: { danger: resource.errors.full_messages } }
    format.json { render json: resource.errors, status: :unprocessable_entity }
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(
        :avatar, :username, :email, :password, :password_confirmation, :new_password, :current_password
      )
    end
  end

  def set_active_storage_host
    ActiveStorage::Current.host = request.base_url
  end
end
