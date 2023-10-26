# frozen_string_literal: true

# Users Entity Controller
class UsersController < Users::RegistrationsController
  before_action :set_user, only: %i[edit update]

  def edit
    super do
      layout 'application'
    end
  end

  def update
    respond_to do |format|
      super do |resource|
        byebug
        if @user.update(user_params)
          handle_successful_update(format, edit_user_registration_path(@user), @user)
        else
          handle_failed_update(format, nil, @user)
        end
      end
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :avatar)
  end
end
