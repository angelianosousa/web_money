class UsersBackoffice::CategoriesController < ApplicationController
  before_action :set_category, only: %i[update destroy]
  
  def index
    @category = Category.where(user: current_user)
  end

  def create
    
  end

  def update
    
  end

  def destroy
    @category.destroy
  end

  private

  def set_category
    @category = Category.find params[:id]
  end
end
