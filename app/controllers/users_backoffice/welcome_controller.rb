class UsersBackoffice::WelcomeController < UsersBackofficeController
  def index
    @user_profile = current_user.user_profile

    @all_recipes = Category.all_recipes(@user_profile)
    @all_expenses = Category.all_expenses(@user_profile)

    @recipes_per_account = Category.recipes_sumatory(@user_profile)
    @expenses_per_account = Category.expenses_sumatory(@user_profile)

    # @category_recipes_per_date = Recurrence.category_per_date_expire(@user_profile, 1)
    # @category_expenses_per_date = Recurrence.category_per_date_expire(@user_profile, 2)

    @balance = Category.balance(@all_recipes, @all_expenses)

    @min_and_max_recipes = Recurrence.min_and_max_recurrences(@user_profile, 1)
    @min_and_max_expenses = Recurrence.min_and_max_recurrences(@user_profile, 2)
  end
end
