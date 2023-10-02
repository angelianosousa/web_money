# frozen_string_literal: true

# == Schema Information
#
# Table name: achievements
#
#  id             :bigint           not null, primary key
#  code           :integer
#  description    :string
#  icon           :string
#  level          :integer          default("golden")
#  points_reached :integer          default(0)
#  total_points   :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
FactoryBot.define do
  factory :achievement do
    user_profile
    code { Faker::Commerce.department }
    goal { 1 }
    reached { 1 }
  end
end
