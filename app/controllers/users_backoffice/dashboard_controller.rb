class UsersBackoffice::DashboardController < UsersBackofficeController
  def index
    @user_profile = current_user.user_profile
    
    # Reccurrents objects filter by type of recurrence
    # I'm use this for sum all recipes and expenses to make a balance and absolutes comparatives too
    @total_recipes  = Transaction.recipes(@user_profile).sum(:price_cents)
    @total_expenses = Transaction.expenses(@user_profile).sum(:price_cents)
    
    # Balance of moviments
    @balance = Transaction.balance(@total_recipes, @total_expenses)

    # Movements objects filter by type of category
    # @recurrences_recipes_per_month = Recurrence.recurrences_per_period(@user_profile, "month", 1)
    # @recurrences_recipes_per_year  = Recurrence.recurrences_per_period(@user_profile, "year", 1)
    
    # @recurrences_expenses_per_month = Recurrence.recurrences_per_period(@user_profile, "month", 2)
    @recipes_period  = Transaction.per_period(@user_profile, params[:period], 'recipe')
    @expenses_period = Transaction.per_period(@user_profile, params[:period], 'expense')
    # @recurrences_expenses_per_year  = Recurrence.recurrences_per_period(@user_profile, "year", 2)

    
  end
end
