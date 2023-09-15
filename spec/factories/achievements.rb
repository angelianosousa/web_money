# == Schema Information
#
# Table name: achievements
#
#  id          :bigint           not null, primary key
#  code        :integer
#  description :string
#  goal        :jsonb
#  icon        :string
#  reached     :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :achievement do
    user_profile { user_profile }
    code { "MyString" }
    goal { 1 }
    reached { 1 }
  end
end
