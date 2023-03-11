class UserProfileController < ApplicationController
  before_action :set_user_profile, only: %i[edit update destroy]

  def edit
  end

  def update
    if @user_profile.update(user_profile_params)
      redirect_to edit_user_profile_path(@user_profile), notice: "Perfil atualizado com sucesso."
    else
      render :edit, alert: @user_profile.errors
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
