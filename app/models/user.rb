class User < ApplicationRecord
  after_create :building_profile

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :user_profile
  has_many :categories, dependent: :destroy
  
  def building_profile
    UserProfile.create(user_id: User.last.id)

    # Category default
    Category.create(title: "Receitas", badge:"success")
    Category.create(title: "Despesas", badge:"danger")

    # Receitas
    Recurrence.create(user_profile_id: User.last.id, category_id: 1, title:"Recebimento 1", price_cents: 1, date_expire: Date.today)
    Recurrence.create(user_profile_id: User.last.id, category_id: 1, title:"Recebimento 2", price_cents: 1, date_expire: Date.today)
    Recurrence.create(user_profile_id: User.last.id, category_id: 1, title:"Recebimento 3", price_cents: 1, date_expire: Date.today)
    # Despesas
    Recurrence.create(user_profile_id: User.last.id, category_id: 2, title:"Internet", price_cents: 1, date_expire: Date.today)
    Recurrence.create(user_profile_id: User.last.id, category_id: 2, title:"Água", price_cents: 1, date_expire: Date.today)
    Recurrence.create(user_profile_id: User.last.id, category_id: 2, title:"Luz", price_cents: 1, date_expire: Date.today)
  end

end
