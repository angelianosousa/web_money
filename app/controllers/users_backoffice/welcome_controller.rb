class UsersBackoffice::WelcomeController < UsersBackofficeController
  def index
    @user_profile = current_user.user_profile

    @all_recipes = Category.all_recipes(@user_profile)
    @all_expenses = Category.all_expenses(@user_profile)

    @recipes_per_account = Category.category_sumatory("Receita", @user_profile)
    @expenses_per_account = Category.category_sumatory("Despesa", @user_profile)

    @category_recipes_per_date = Recurrence.category_per_date_expire(@user_profile, 1, params[:period])
    @category_expenses_per_date = Recurrence.category_per_date_expire(@user_profile, 2, params[:period])

    @balance = Recurrence.balance(@user_profile)

    @min_and_max_recipes = Recurrence.min_and_max_recipes(@user_profile)
    @min_and_max_expenses = Recurrence.min_and_max_expenses(@user_profile)
  end

end
