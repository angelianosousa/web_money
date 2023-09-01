# == Schema Information
#
# Table name: achievements
#
#  id              :bigint           not null, primary key
#  code            :integer
#  goal            :integer
#  message         :string
#  reached         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_profile_id :bigint           not null
#
# Indexes
#
#  index_achievements_on_user_profile_id  (user_profile_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_profile_id => user_profiles.id)
#
FactoryBot.define do
  factory :achievement do
    user_profile { user_profile }
    code { "MyString" }
    goal { 1 }
    reached { 1 }
  end
end
