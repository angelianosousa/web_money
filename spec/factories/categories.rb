# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id            :bigint           not null, primary key
#  category_type :integer          default("recipe"), not null
#  title         :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_categories_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :category do
    user_id       { create(:user).id }
    title         { Faker::Lorem.word }
    category_type { 'recipe' }

    trait :invalid do
      user_id       {}
      category_type {}
      title         {}
    end
  end
end
