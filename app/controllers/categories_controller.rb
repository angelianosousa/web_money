class CategoriesController < ApplicationController
  before_action :set_category, only: %i[edit update destroy]

  def index
    @categories = current_profile.categories.order(:category_type)
  end

  def edit
  end

  def create
    @category = current_profile.categories.build(category_params)

    if @category.save
      redirect_to categories_path, flash: { success: t('.success') }
    else
      redirect_to categories_path, flash: { danger: @category.errors.full_messages.to_sentence }
    end
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path, flash: { success: t('.success') }
    else
      redirect_to categories_path, flash: { danger: @category.errors.full_messages.to_sentence }
    end
  end

  def destroy
    @category.destroy

    redirect_to categories_path, flash: { success: t('.success') }
  end

  private

  def set_category
    @category = current_profile.categories.find params[:id]
  end

  def category_params
    params.require(:category).permit(:title, :category_type, :user_profile_id)
  end
end
