class Transaction < ApplicationRecord
  belongs_to :recurrence
  belongs_to :category
  belongs_to :user_profile

  # Money Rails 
  monetize :price_cents
  register_currency :brl

  # Validations
  validates :title, :date, presence: true

  # Kaminari
  paginates_per 12

  # Scope Methods
  scope :_search_, ->(title, page, user_profile, order_per_attribute, up_down){ 
    unless order_per_attribute
      where("lower(title) LIKE ? and user_profile_id = #{user_profile}", "%#{title.downcase}%").includes(:recurrence => :category).page(page)
    else
      order("#{order_per_attribute}": :"#{up_down}").page(page)
    end
  }

  scope :transactions_recipes, -> (user_profile_id){ 
  # Category.first.recurrences.where(user_profile: user_profile).includes(:transactions).sum(:price_cents)
  # Transaction.where(user_profile_id: 1, category_id: 1).group(:recurrence).sum(:price_cents)
    where(user_profile_id: user_profile_id, category_id: 1).group(recurrence: [:title]).sum(:price_cents)
  }
end
