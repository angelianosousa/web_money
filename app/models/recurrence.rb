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

  scope :min_and_max_recurrences, ->(user_profile, category){ 
    accounts_hash = where("category_id = #{category} and user_profile_id = #{user_profile.id}").group(:title).group_by_month(:date_expire, format:"%b %Y").minimum(:price_cents)
    {accounts_hash.keys.min => accounts_hash.values.min, 
      accounts_hash.keys.max => accounts_hash.values.max}
  }

end
