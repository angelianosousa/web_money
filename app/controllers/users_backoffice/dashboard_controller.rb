class UsersBackoffice::DashboardController < UsersBackofficeController
  def index
    @user_profile = current_user.user_profile

    params[:q] ||= { user_profile_id_eq: @user_profile.id }

    @q = Transaction.ransack(params[:q])

    @transactions = @q.result(distinct: true).includes(:account, :category)    
  end
end
