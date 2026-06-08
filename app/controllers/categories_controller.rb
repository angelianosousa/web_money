# frozen_string_literal: true

# Categories Entity Controller
class CategoriesController < ApplicationController
  before_action :set_category, only: %i[edit update destroy]

  def index
    @categories = current_user.categories.order(:category_type)
  end

  def edit; end

  def create
    @category = current_user.categories.new(category_params)

    respond_to do |format|
      if @category.save
        handle_successful_creation(format, categories_path, @category)
      else
        handle_failed_creation(format, categories_path, @category)
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        handle_successful_update(format, categories_url, @category)
      else
        handle_failed_update(format, edit_category_path(@category), @category)
      end
    end
  end

  def destroy
    @category.destroy

    redirect_to categories_path, flash: { success: t('.success') }
  end

  private

  def set_category
    @category = current_user.categories.find params[:id]
  end

  def category_params
    params.require(:category).permit(:title, :category_type, :user_id)
  end
end
