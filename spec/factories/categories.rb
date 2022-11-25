# == Schema Information
#
# Table name: categories
#
#  id              :bigint           not null, primary key
#  title           :string           not null
#  user_profile_id :bigint
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  category_type   :integer          default("recipe")
#
FactoryBot.define do
  factory :category do
    title { "MyString" }
  end
end
