# frozen_string_literal: true

# Categories Entity Controller
class CategoriesController < ApplicationController
  before_action :set_category, only: %i[edit update destroy]

  def index
    @categories = current_profile.categories.order(:category_type)
  end

  def edit; end

  def create
    @category = current_profile.categories.build(category_params)

    respond_to do |format|
      if @category.save
        handle_successful_creation(format, categories_path, @budget)
      else
        handle_failed_creation(format, categories_path, @budget)
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        handle_successful_update(format, categories_url, @category)
      else
        handle_failed_update(format, nil, @category)
      end
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
