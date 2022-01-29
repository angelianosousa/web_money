class User < ApplicationRecord
  after_create :building_profile
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :user_profile

  def building_profile
    UserProfile.create(user_id: User.last.id)
  end
end
