module CategoriesHelper
  def category_options_for_select
    current_user_profile.categories.collect { |c| [ c.title.upcase, c.id ] }
  end
end
