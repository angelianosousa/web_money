# == Schema Information
#
# Table name: transactions
#
#  id              :bigint           not null, primary key
#  account_id   :bigint
#  title           :string
#  price_cents     :integer          default(0), not null
#  price_currency  :string           default("BRL"), not null
#  date            :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_profile_id :bigint
#  move_type       :integer          not null
#  category_id     :bigint           not null
#
class Transaction < ApplicationRecord
  enum move_type: %i[recipe expense]

  # Record Relations
  belongs_to :account
  belongs_to :user_profile
  belongs_to :category

  # Money Rails 
  monetize :price_cents
  register_currency :brl

  # Validations
  validates :date, presence: true

  # Kaminari
  paginates_per 12

  # Callbacks
  after_save :operate_account

  # Scope for index transactions
  scope :default, ->(page, count_objects, transactions){
    @transaction_per_days = {}

    transactions_days_for_current_user = transactions.pluck(:date)
    
    transactions_days_for_current_user.each do |day|      
      @transaction_per_days["#{day.strftime('%d/%m/%Y')}"] = transactions.select { |transaction| transaction.date.beginning_of_day == day.beginning_of_day }
    end

    Kaminari.paginate_array(@transaction_per_days.to_a).page(page).per(count_objects)
  }

  def operate_account
    @account = Account.find(account_id)
    @account.price_cents -= price_cents.to_i if move_type == 'expense'
    @account.price_cents += price_cents.to_i if move_type == 'recipe'
    @account.save!
  end

  # Scope Methods
  # Search any transactions

  # Search transactions separete by account
  scope :_search_transactions_per_account, -> (account, user_profile_id, page){
    where("account_id = #{account} and user_profile_id = #{user_profile_id}").includes(:category).page(page)
  }

  scope :min_and_max_recipes, ->(){
    max_recipes = recipes.maximum(:price_cents)
    min_recipes = recipes.minimum(:price_cents)

    { max: max_recipes, min: min_recipes }
  }

  scope :min_and_max_expenses,->(){
    max_expenses = expenses.maximum(:price_cents)
    min_expenses = expenses.minimum(:price_cents)

    { max: max_expenses, min: min_expenses }
  }

  scope :balance,->(){
    { balance: recipes.sum(:price_cents) - expenses.sum(:price_cents) }
  }

  scope :recipes,-> (){
    where(move_type: :recipe).includes(:account, :category)
  }

  # Filter per transactions expenses
  scope :expenses,-> (){
    where(move_type: :expense).includes(:account, :category)
  }

  scope :per_period, -> (user_profile, period = 'month', move_type){
    if period == 'week'
      where(user_profile: user_profile, move_type: move_type).includes(:account, :category).group_by_week(:date, format:"%b %Y").group(:price_cents).sum(:price_cents)
    elsif period == 'year'
      where(user_profile: user_profile, move_type: move_type).includes(:account, :category).group_by_year(:date, format:"%b %Y").group(:price_cents).sum(:price_cents)
    else
      where(user_profile: user_profile, move_type: move_type).includes(:account, :category).group_by_month(:date, format:"%b %Y").group(:price_cents).sum(:price_cents)
    end
  }
end
