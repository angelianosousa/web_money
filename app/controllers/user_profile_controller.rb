# frozen_string_literal: true

class UserProfileController < ApplicationController
  before_action :set_user_profile, only: %i[edit update destroy]

  def edit; end

  def update
    if @user_profile.update(user_profile_params)
      redirect_to edit_user_profile_path(@user_profile), flash: { success: t('.success') }
    else
      render :edit, danger: @user_profile.errors
    end
  end

  private

  def set_user_profile
    @user_profile = UserProfile.find(params[:id])
  end

  def user_profile_params
    params.require(:user_profile).permit(:name, :avatar)
  end
end
