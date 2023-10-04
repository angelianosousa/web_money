# frozen_string_literal: true

module CategoriesHelper
  def category_options_for_select(filter = '')
    if filter == 'recipe'
      current_profile.categories.recipes.collect { |c| [c.title.upcase, c.id] }
    elsif filter == 'expense'
      current_profile.categories.expenses.collect { |c| [c.title.upcase, c.id] }
    else
      current_profile.categories.collect { |c| [c.title.upcase, c.id] }
    end
  end

  def category_type_options_for_select
    translations_scope = %i[helpers category_type_options_for_select]

    Category.category_types.map do |status_key, _value|
      [t(status_key, scope: translations_scope), status_key]
    end
  end
end
