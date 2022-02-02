class Recurrence < ApplicationRecord
  belongs_to :user_profile
  belongs_to :category
  has_many :transactions, dependent: :destroy

  # Validations
  validates :title, :value, :date_expire, presence: true

  # Kaminari
  paginates_per 12

  # Scope Methods
  scope :_search_, ->(title, page, user_profile, recurrence_category){ 
    unless recurrence_category
      where("lower(title) LIKE ? and user_profile_id = #{user_profile.id}", "%#{title.downcase}%").page(page)
    else
      where(category_id: recurrence_category, user_profile_id: user_profile.id).page(page)
    end
  }

  scope :category_per_date_expire, -> (user_profile, category, period){ 
    recurrences = where(user_profile: user_profile, category_id: category).includes(:transactions)

    if period.nil? || period == "Mês"
      recurrences.group_by_month(:date_expire).sum(:value)  
    elsif period == "Semana"
      recurrences.group_by_week(:date_expire).sum(:value)  
    elsif period == "Day"
      recurrences.group_by_day(:date_expire).sum(:value)
    elsif period == "Ano"
      recurrences.group_by_year(:date_expire).sum(:value)  
    end
  }

  scope :balance, ->(user_profile){ 
    { 'Receita': where(category_id: 1, user_profile: user_profile).includes(:transactions).sum(:value), 
      'Despesa': where(category_id: 2, user_profile: user_profile).includes(:transactions).sum(:value) }
  }

  scope :min_and_max_recipes, ->(user_profile){ 
    account = where("category_id = 1 and user_profile_id = #{user_profile.id}").select(:title, :value)
    { "#{account.minimum(:title)}": account.minimum(:value), "#{account.maximum(:title)}": account.maximum(:value) }
  }

  scope :min_and_max_expenses, ->(user_profile){ 
    account = where("category_id = 2 and user_profile_id = #{user_profile.id}").select(:title, :value)
    { "#{account.minimum(:title)}": account.minimum(:value), "#{account.maximum(:title)}": account.maximum(:value) }
  }
end
