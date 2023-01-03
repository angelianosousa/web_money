module UsersBackoffice::CategoriesHelper
  def category_options_for_select
    Category.all.collect { |c| [ c.title, c.id ] }
  end
end
