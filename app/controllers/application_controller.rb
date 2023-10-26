# frozen_string_literal: true

# Base Application Entity Controller
class ApplicationController < ActionController::Base
  add_flash_types :notice, :alert, :warning
  before_action :authenticate_user!

  layout :layout_by_resource

  helper_method :current_user

  def layout_by_resource
    # profile_edit = 
    if controller_name == 'registrations' && action_name == 'edit'
      'application'
    elsif devise_controller?
      'user_devise'
    else
      'application'
    end

    # devise_controller? ? "#{resource_class.to_s.downcase}_devise" : 'application'
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
    format.html { redirect_to to_path, flash: { danger: resource.errors.full_messages.to_sentence } }
    format.js   { flash.now[:danger] = resource.errors.full_messages.to_sentence }
    format.json { render json: resource.errors, status: :unprocessable_entity }
  end

  # UPDATE
  def handle_successful_update(format, to_path, resource)
    format.html { redirect_to to_path, flash: { success: t('.success') } }
    format.json { render :show, status: :ok, location: resource }
  end

  def handle_failed_update(format, to_path, resource)
    format.html { redirect_to to_path, flash: { danger: resource.errors.full_messages.to_sentence } }
    format.json { render json: resource.errors, status: :unprocessable_entity }
  end
end
