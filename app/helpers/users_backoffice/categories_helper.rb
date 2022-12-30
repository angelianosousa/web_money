module UsersBackoffice::CategoriesHelper
  def category_options_for_select(category_type = '')
    categories = Category.all

    if category_type == 'receive'
      categories.recipes.order(:category_type).map { |category| ["#{category.title} - #{category.category_type.capitalize}", category.id] }
    elsif category_type == 'pay'
      categories.expenses.order(:category_type).map { |category| ["#{category.title} - #{category.category_type.capitalize}", category.id] }
    else
      categories
    end
  end
end
