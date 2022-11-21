class UsersBackoffice::DashboardController < UsersBackofficeController

  def index
    params[:q] ||= { user_profile_id_eq: current_user.user_profile.id }

    @q = Transaction.ransack(params[:q])

    @transactions = @q.result(distinct: true).includes(:account, :category)

    @accounts = Account.group(:title).sum(:price_cents)

    @category_per_recipes = Category.recipes.group(:title).sum(:price_cents)
    @category_per_expenses = Category.expenses.group(:title).sum(:price_cents)
  end
end
