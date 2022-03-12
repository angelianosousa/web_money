class Recurrence < ApplicationRecord
  belongs_to :user_profile
  belongs_to :category
  has_many :transactions, dependent: :destroy

  # Money Rails
  monetize :price_cents
  register_currency :brl

  # Validations
  validates :title, presence: true

  # Kaminari
  paginates_per 12

  # Scope Methods
  scope :_search_, ->(title, page, user_profile_id, category_id){ 
    unless category_id
      where("lower(title) LIKE ? and user_profile_id = ?", "%#{title.strip.downcase}%", "#{user_profile_id}").page(page)
    else
      where(category_id: category_id, user_profile_id: user_profile_id).page(page)
    end
  }

  scope :category_per_date_expire, -> (user_profile, category){
    where(user_profile: user_profile, category_id: category).includes(:transactions).group_by_month(:date_expire, series: false, format: "%b %Y").sum(:price_cents)
  }

  scope :min_and_max_recurrences, ->(user_profile, category){ 
    account = where("category_id = #{category} and user_profile_id = #{user_profile.id}")    
    { "#{account.minimum(:title)}": account.minimum(:price_cents), "#{account.maximum(:title)}": account.maximum(:price_cents) }
  }

end
