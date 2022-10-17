# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class User < ApplicationRecord
  after_create :building_profile

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :user_profile
  
  def building_profile
    user_profile = UserProfile.create(user_id: User.last.id)

    Recurrence.create(user_profile_id: user_profile, title:"Banco X", price_cents: 1000)
    Recurrence.create(user_profile_id: user_profile, title:"Banco Y", price_cents: 1000)
  end

end
