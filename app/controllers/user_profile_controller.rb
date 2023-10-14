# frozen_string_literal: true

# User Profile Entity Controller
class UserProfileController < ApplicationController
  before_action :set_user_profile, only: %i[edit update]

  def edit; end

  def update
    respond_to do |format|
      if @user_profile.update(user_profile_params)
        handle_successful_update(format, edit_user_profile_path(@user_profile), @user_profile)
      else
        handle_failed_update(format, nil, @user_profile)
      end
    end
  end

  private

  def set_user_profile
    @user_profile = current_profile
  end

  def user_profile_params
    params.require(:user_profile).permit(:name, :avatar)
  end
end
