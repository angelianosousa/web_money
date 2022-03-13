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
    @transactions_recipes_per_date = Transaction.transactions_recipes_per_date(@user_profile)
    @transactions_expenses_per_date = Transaction.transactions_expenses_per_date(@user_profile)

    # Min and Max by recipes and expenses
    @min_and_max_recipes = Recurrence.min_and_max_recurrences(@user_profile, 1)
    @min_and_max_expenses = Recurrence.min_and_max_recurrences(@user_profile, 2)
  end
end
