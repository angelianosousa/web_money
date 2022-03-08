class Transaction < ApplicationRecord
  belongs_to :recurrence
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

  scope :transactions_on_time, -> (user_profile){ 
    where(user_profile: user_profile).group_by_month(:date).sum(:price_cents)
  }
end
