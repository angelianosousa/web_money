module CategoriesHelper
  def category_options_for_select(move_type='')
    if move_type == 'recipe'
      current_profile.categories.recipes.collect { |c| [ c.title.upcase, c.id ] }
    elsif move_type == 'expense'
      current_profile.categories.expenses.collect { |c| [ c.title.upcase, c.id ] }
    else
      current_profile.categories.collect { |c| [ c.title.upcase, c.id ] }
    end
  end

  def category_type_options_for_select
    translations_scope = %i[helpers category_type_options_for_select]

    Category.category_types.map do |status_key, _value|
      [t(status_key, scope: translations_scope), status_key]
    end
  end
end
