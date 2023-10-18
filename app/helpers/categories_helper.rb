# frozen_string_literal: true

# Categories Helper
module CategoriesHelper
  def category_options_for_select(filter)
    map_category_options.fetch(filter.to_sym).call
  end

  def category_type_options_for_select
    translations_scope = %i[helpers category_type_options_for_select]

    Category.category_types.map do |status_key, _value|
      [t(status_key, scope: translations_scope), status_key]
    end
  end

  def map_category_options
    {
      'all':     -> { current_profile.categories.collect { |c| [c.title.upcase, c.id] } },
      'recipe':  -> { current_profile.categories.recipes.collect { |c| [c.title.upcase, c.id] } },
      'expense': -> { current_profile.categories.expenses.collect { |c| [c.title.upcase, c.id] } }
    }
  end
end
