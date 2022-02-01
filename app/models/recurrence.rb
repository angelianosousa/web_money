class Recurrence < ApplicationRecord
  belongs_to :user_profile
  belongs_to :category
  has_many :transactions, dependent: :destroy

  # Validations
  validates :title, :value, :date_expire, presence: true

  # Kaminari
  paginates_per 12

  # Scope Methods
  scope :_search_, ->(title, page){ 
    where("lower(title) LIKE ?", "%#{title.downcase}%")
    .page(page)
  }

  scope :category_per_date_expire, -> (user_profile, category, period){ 
    if period.nil? || period == "Mês"
      where(user_profile: user_profile, category_id: category).includes(:transactions).group_by_month(:date_expire).sum(:value)  
    elsif period == "Semana"
      where(user_profile: user_profile, category_id: category).includes(:transactions).group_by_week(:date_expire).sum(:value)  
    elsif period == "Day"
      where(user_profile: user_profile, category_id: category).includes(:transactions).group_by_month(:date_expire).sum(:value)
    elsif period == "Ano"
      where(user_profile: user_profile, category_id: category).includes(:transactions).group_by_year(:date_expire).sum(:value)  
    end
  }

  scope :balance, ->(user_profile){ 
    { 'Receita': where(category_id: 1, user_profile: user_profile).includes(:transactions).sum(:value), 
      'Despesa': where(category_id: 2, user_profile: user_profile).includes(:transactions).sum(:value) }
  }

  scope :min_and_max_recipes, ->(user_profile){ 
    account = where(category_id: 1, user_profile: user_profile).select(:id, :title, :value)
    { "#{account.minimum(:title)}": account.minimum(:value), "#{account.maximum(:title)}": account.maximum(:value) }
  }

  scope :min_and_max_expenses, ->(user_profile){ 
    account = where(category_id: 2, user_profile: user_profile).select(:id, :title, :value)
    { "#{account.minimum(:title)}": account.minimum(:value), "#{account.maximum(:title)}": account.maximum(:value) }
  }
end
