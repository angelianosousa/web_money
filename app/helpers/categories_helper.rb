module CategoriesHelper
  def category_options_for_select
    current_user_profile.categories.collect { |c| [ c.title.upcase, c.id ] }
  end

  def navlink_category
    link_to categories_path, class:'navbar-brand navbar-link mb-3' do
      "#{t '.title'}"
    end
  end

  def category_type_options_for_select
    translations_scope = %i[helpers category_type_options_for_select]

    Category.category_types.map do |status_key, value|
      [t(status_key, scope: translations_scope), value]
    end
  end
end
