# == Schema Information
#
# Table name: plans
#
#  id              :bigint           not null, primary key
#  date_limit      :datetime
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_profile_id :bigint           not null
#
# Indexes
#
#  index_plans_on_user_profile_id  (user_profile_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_profile_id => user_profiles.id)
#
FactoryBot.define do
  factory :plan do
    name { "MyString" }
    date_limit { "2023-08-03 21:55:21" }
    user_profile { nil }
  end
end
