# == Schema Information
#
# Table name: transactions
#
#  id              :bigint           not null, primary key
#  recurrence_id   :bigint
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
  belongs_to :recurrence, optional: true
  belongs_to :user_profile
  belongs_to :category

  # Money Rails 
  monetize :price_cents
  register_currency :brl

  # Validations
  validates :title, :date, presence: true

  # Kaminari
  paginates_per 12

  # Scope for index transactions
  scope :default, ->(page, count_objects, transactions){
    @transaction_per_days = {}

    transactions_days_for_current_user = transactions.pluck(:date)
    
    transactions_days_for_current_user.each do |day|      
      @transaction_per_days["#{day.strftime('%d/%m/%Y')}"] = transactions.select { |transaction| transaction.date.beginning_of_day == day.beginning_of_day }
    end

    Kaminari.paginate_array(@transaction_per_days.to_a).page(page).per(count_objects)
  }

  # Scope Methods
  # Search any transactions
  scope :_search_transactions, -> (title, user_profile_id, page){
    where("lower(title) LIKE ? and user_profile_id = ?", "%#{title.downcase}%", "#{user_profile_id}").includes(:recurrence => :category).page(page)
  }

  # Search transactions separete by recurrence
  scope :_search_transactions_per_recurrence, -> (recurrence, user_profile_id, page){
    where("recurrence_id = #{recurrence} and user_profile_id = #{user_profile_id}").includes(:category).page(page)
  }

  # Filter transactions recipes classified per date
  scope :transactions_recipes_per, -> (user_profile, period){
    if period == "month"
      where(user_profile: user_profile, move_type: :RECIPE).group_by_month(:date, format: "%b %Y").group(:title).sum(:price_cents)
    elsif period == "year"
      where(user_profile: user_profile, move_type: :RECIPE).group_by_year(:date, format: "%b %Y").group(:title).sum(:price_cents)
    else
      where(user_profile: user_profile, move_type: :RECIPE).group_by_week(:date, format: "%b %Y", week_start: :monday).group(:title).sum(:price_cents)
    end
  }

  # Filter transactions expenses classified per date
  scope :transactions_expenses_per, -> (user_profile, period){
    if period == "month"
      where(user_profile: user_profile, move_type: :EXPENSE).group(:title).group_by_month(:date, format: "%b %Y").sum(:price_cents)
    elsif period == "year"
      where(user_profile: user_profile, move_type: :EXPENSE).group(:title).group_by_year(:date, format: "%b %Y").sum(:price_cents)
    else
      where(user_profile: user_profile, move_type: :EXPENSE).group(:title).group_by_week(:date, format: "%b %Y", week_start: :monday).sum(:price_cents)
    end
  }

  # Filter per transactions recipes
  scope :transactions_recipes, -> (user_profile){
    where(user_profile: user_profile, move_type: :RECIPE).group(:title).sum(:price_cents)
  }

  # Filter per transactions expenses
  scope :transactions_expenses, -> (user_profile){
    where(user_profile: user_profile, move_type: :EXPENSE).group(:title).sum(:price_cents)
  }

  # Balance for all moviments
  scope :balance, ->(recipes, expenses){ recipes.values.sum - expenses.values.sum }
end
