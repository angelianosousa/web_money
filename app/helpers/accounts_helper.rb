module AccountsHelper
  def categories_for_select
    Category.order(:title).map { |category| [category.title, category.id] }
  end
end
