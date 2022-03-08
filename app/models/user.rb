class User < ApplicationRecord
  after_create :building_profile
  after_create :building_categories
  after_create :default_accounts
  #Ex:- :default =>''
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :user_profile
  has_many :categories, dependent: :destroy
  
  def building_profile
    UserProfile.create(user_id: User.last.id)
  end

  def building_categories
    Category.create(title: "Receitas", badge:"success")
    Category.create(title: "Despesas", badge:"danger")
  end

  def default_accounts
    # Receitas
    Recurrence.create(user_profile_id: User.last.id, category_id: 1, title:"Pagamento 1", price_cents: 200.00)
    Recurrence.create(user_profile_id: User.last.id, category_id: 1, title:"Pagamento 2", price_cents: 200.00)
    Recurrence.create(user_profile_id: User.last.id, category_id: 1, title:"Pagamento 3", price_cents: 350.00)
    # Despesas
    Recurrence.create(user_profile_id: User.last.id, category_id: 2, title:"Conta de Internet", price_cents: 100.00)
    Recurrence.create(user_profile_id: User.last.id, category_id: 2, title:"Conta de Água", price_cents: 200.00)
    Recurrence.create(user_profile_id: User.last.id, category_id: 2, title:"Conta de Luz", price_cents: 300.00)
  end
end
