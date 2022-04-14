class UsersBackoffice::WelcomeController < UsersBackofficeController
  def index
    @user_profile = current_user.user_profile
    
    # Reccurrents objects filter by type of recurrence
    # I'm use this for sum all recipes and expenses to make a balance and absolutes comparatives too
    @recipes_per_account = Transaction.transactions_recipes(@user_profile)
    @expenses_per_account = Transaction.transactions_expenses(@user_profile)
    
    # Balance of moviments
    @balance = Transaction.balance(@recipes_per_account, @expenses_per_account)

    # Movements objects filter by type of category
    @recurrences_recipes_per_month = Recurrence.recurrences_per_period(@user_profile, "month", 1)
    @recurrences_recipes_per_week = Recurrence.recurrences_per_period(@user_profile, "week", 1)
    @recurrences_recipes_per_year = Recurrence.recurrences_per_period(@user_profile, "year", 1)

    @recurrences_expenses_per_month = Recurrence.recurrences_per_period(@user_profile, "month", 2)
    @recurrences_expenses_per_week = Recurrence.recurrences_per_period(@user_profile, "week", 2)
    @recurrences_expenses_per_year = Recurrence.recurrences_per_period(@user_profile, "year", 2)
  end
end
