# == Schema Information
#
# Table name: recurrences
#
#  id              :bigint           not null, primary key
#  user_profile_id :bigint
#  title           :string
#  price_cents     :integer          default(0), not null
#  price_currency  :string           default("BRL"), not null
#  pay             :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Recurrence < ApplicationRecord

  belongs_to :user_profile
  has_many :transactions, dependent: :destroy

  # Money Rails
  monetize :price_cents
  register_currency :brl

  # Validations
  validates :title, presence: true

  # Kaminari
  paginates_per 12

  # Scope Methods
  # scope :_search_, ->(title, page, user_profile_id, category){ 
  #   unless category
  #     where("lower(title) LIKE ? and user_profile_id = ?", "%#{title.strip.downcase}%", user_profile_id).page(page)
  #   else
  #     where(category: category, user_profile_id: user_profile_id).page(page)
  #   end
  # }

  # scope :recurrences_per_period, -> (user_profile_id, period, category){ 
  #   if period == "week"
  #     where(category: category, user_profile_id: user_profile_id).includes(:transactions).group_by_week(:date_expire, format:"%b %Y").group(:title).sum(:price_cents)
  #   elsif period == "year"
  #     where(category: category, user_profile_id: user_profile_id).includes(:transactions).group_by_year(:date_expire, format:"%b %Y").group(:title).sum(:price_cents)
  #   else
  #     where(category: category, user_profile_id: user_profile_id).includes(:transactions).group_by_month(:date_expire, format:"%b %Y").group(:title).sum(:price_cents)
  #   end
  # }

  # scope :min_and_max_recurrences, ->(user_profile, category){ 
  #   accounts_hash = where("category = #{category} and user_profile_id = #{user_profile.id}").group(:title).group_by_month(:date_expire, format:"%b %Y").minimum(:price_cents)
  #   {"#{accounts_hash.keys.min}" => accounts_hash.values.min, 
  #     "#{accounts_hash.keys.max}" => accounts_hash.values.max}
  # }

end
