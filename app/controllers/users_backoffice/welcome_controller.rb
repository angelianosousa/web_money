class UsersBackoffice::WelcomeController < UsersBackofficeController
  def index
    @all_recipes = Category.all_recipes
    @all_expenses = Category.all_expenses 

    @recipes_per_category = Category.category_sumatory("Receita", params[:recurrence_title])
    @expenses_per_category = Category.category_sumatory("Despesa", params[:recurrence_title])

    @category_recipes_per_date_expire = Category.category_per_date_expire(1, params[:period])
    @category_expenses_per_date_expire = Category.category_per_date_expire(2, params[:period])

    @balance = Category.balance

    @min_and_max_recipes = Category.min_and_max_recipes
    @min_and_max_expenses = Category.min_and_max_expenses
  end

end
