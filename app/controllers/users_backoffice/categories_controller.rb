class UsersBackoffice::CategoriesController < UsersBackofficeController
  before_action :set_category, only: %i[edit update destroy]

  def index
    @categories = Category.where(user_profile: current_user.user_profile).order(:category_type)
  end

  def edit
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to users_backoffice_categories_path, notice: 'Category was successfully created'
    else
      redirect_to users_backoffice_categories_path, alert: @category.errors.full_messages
    end
  end

  def update
    if @category.update(category_params)
      redirect_to users_backoffice_categories_path, notice: 'Category was successfully updated'
    else
      redirect_to users_backoffice_categories_path, alert: @category.errors.full_messages
    end
  end

  def destroy
    @category.destroy

    redirect_to users_backoffice_categories_path
  end

  private

  def set_category
    @category = Category.find params[:id]
  end

  def category_params
    params.require(:category).permit(:title, :category_type, :user_profile_id)
  end
end
