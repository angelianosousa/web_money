# frozen_string_literal: true

# == Schema Information
#
# Table name: transactions
#
#  id             :bigint           not null, primary key
#  date           :date
#  description    :text
#  move_type      :integer          default("recipe"), not null
#  price_cents    :integer          not null
#  price_currency :string           default("BRL"), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  account_id     :bigint
#  bill_id        :bigint
#  budget_id      :bigint
#  category_id    :bigint
#  user_id        :bigint           not null
#
# Indexes
#
#  index_transactions_on_account_id   (account_id)
#  index_transactions_on_bill_id      (bill_id)
#  index_transactions_on_budget_id    (budget_id)
#  index_transactions_on_category_id  (category_id)
#  index_transactions_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (bill_id => bills.id)
#  fk_rails_...  (budget_id => budgets.id)
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :transaction do
    user_id     { create(:user).id }
    category_id { create(:category).id }
    account_id  { create(:account).id }
    description { Faker::Lorem.paragraph(sentence_count: 2) }
    price       { rand(100..500) }
    date        { Faker::Date.in_date_period }
    move_type   { 'recipe' }

    trait :recipe do
      category  { create(:category, category_type: :recipe) }
      move_type { 'recipe' }
    end

    trait :expense do
      category  { create(:category, category_type: :expense) }
      move_type { 'expense' }
    end

    trait :with_bill do
      bill { create(:bill) }
    end

    trait :with_budget do
      budget { create(:budget) }
    end

    trait :invalid do
      user_id     {}
      category_id {}
      account_id  {}
      description {}
      price       {}
      move_type   {}
      date        {}
    end
  end
end
