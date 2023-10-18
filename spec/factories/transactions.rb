# frozen_string_literal: true

# == Schema Information
#
# Table name: transactions
#
#  id              :bigint           not null, primary key
#  date            :date
#  description     :text
#  move_type       :integer          default("recipe"), not null
#  price_cents     :integer          default(0), not null
#  price_currency  :string           default("BRL"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  account_id      :bigint
#  bill_id         :bigint
#  budget_id       :bigint
#  category_id     :bigint
#  user_profile_id :bigint
#
# Indexes
#
#  index_transactions_on_account_id       (account_id)
#  index_transactions_on_bill_id          (bill_id)
#  index_transactions_on_budget_id        (budget_id)
#  index_transactions_on_category_id      (category_id)
#  index_transactions_on_user_profile_id  (user_profile_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (bill_id => bills.id)
#  fk_rails_...  (budget_id => budgets.id)
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (user_profile_id => user_profiles.id)
#
FactoryBot.define do
  factory :transaction do
    user_profile_id { create(:user_profile).id }
    category_id     { create(:category).id }
    account_id      { create(:account).id }
    description     { Faker::Lorem.paragraph(sentence_count: 2) }
    price_cents     { rand(100..1000) }
    date            { Faker::Date.in_date_period }
    move_type       { 'recipe' }

    trait :recipe do
      category { create(:category, category_type: :recipe) }
    end
  
    trait :expense do
      category { create(:category, category_type: :expense) }
    end
  
    trait :with_bill do
      bill { create(:bill) }
    end
  
    trait :with_budget do
      budget { create(:budget) }
    end
  
    trait :invalid do
      user_profile_id {}
      category_id     {}
      account_id      {}
      description     {}
      price_cents     {}
      move_type       {}
      date            {}
    end
  end

end
