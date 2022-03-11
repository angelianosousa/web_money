class UsersBackoffice::WelcomeController < UsersBackofficeController
  def index
    @user_profile = current_user.user_profile

    @all_recipes = Transaction.transactions_recipes(@user_profile)
    @all_expenses = Transaction.transactions_expenses(@user_profile)

    @recipes_per_account = Category.recipes_sumatory(@user_profile)
    @expenses_per_account = Category.expenses_sumatory(@user_profile)

    # @category_recipes_per_date = Recurrence.category_per_date_expire(@user_profile, 1)
    # @category_expenses_per_date = Recurrence.category_per_date_expire(@user_profile, 2)

    # TODO Gráfico de transações que são receitas organizadas por meses
    @transactions_recipes_per_date = nil#Transaction.transactions_recipes_per_date(@user_profile)
    # TODO Gráfico de transações que são despesas organizadas por meses
    @transactions_expenses_per_date = nil

    @balance = Category.balance(@all_recipes, @all_expenses)

    @min_and_max_recipes = Recurrence.min_and_max_recurrences(@user_profile, 1)
    @min_and_max_expenses = Recurrence.min_and_max_recurrences(@user_profile, 2)
  end
end
