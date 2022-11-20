module UsersBackoffice::CategoriesHelper
  def category_options_for_select
    Category.order(:category_type).map { |category| ["#{category.title} - #{category.category_type.capitalize}", category.id] }
  end
end
