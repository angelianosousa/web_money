# == Schema Information
#
# Table name: transactions
#
#  id              :bigint           not null, primary key
#  date            :date
#  description     :text
#  price_cents     :decimal(, )      default(0.0), not null
#  price_currency  :string           default("BRL"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  account_id      :bigint
#  bill_id         :bigint
#  category_id     :bigint           not null
#  user_profile_id :bigint
#
# Indexes
#
#  index_transactions_on_account_id       (account_id)
#  index_transactions_on_bill_id          (bill_id)
#  index_transactions_on_category_id      (category_id)
#  index_transactions_on_user_profile_id  (user_profile_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (bill_id => bills.id)
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (user_profile_id => user_profiles.id)
#
class Transaction < ApplicationRecord

  # Record Relations
  belongs_to :account
  belongs_to :user_profile
  belongs_to :category
  belongs_to :bill, optional: true

  # Money Rails 
  monetize :price_cents
  register_currency :brl

  # Validations
  validates :date, presence: true

  # Callbacks
  after_save :operate_account

  paginates_per 7

  def operate_account
    @account = Account.find(account_id)
    @account.price_cents -= price_cents.to_i if category.category_type == 'expense'
    @account.price_cents += price_cents.to_i if category.category_type == 'recipe'
    @account.save
  end

  # Scope Methods

  scope :default, ->(page, count_objects, transactions){
    @transaction_per_days = {}

    transactions_days_for_current_user = transactions.pluck(:date)
    
    transactions_days_for_current_user.each do |day|
      @transaction_per_days["#{day.strftime('%d/%m/%Y')}"] = transactions.select { |transaction| transaction.date.beginning_of_day == day.beginning_of_day }
    end

    Kaminari.paginate_array(@transaction_per_days.to_a).page(page).per(count_objects)
  }
  
  scope :recipes,-> (){
    where(category_id: Category.where(category_type: :recipe)).includes(:account, :category)
  }

  scope :expenses,-> (){
    where(category_id: Category.where(category_type: :expense)).includes(:account, :category)
  }
end
