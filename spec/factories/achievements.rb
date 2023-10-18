# frozen_string_literal: true

# == Schema Information
#
# Table name: achievements
#
#  id          :bigint           not null, primary key
#  code        :integer
#  description :string
#  level       :integer          default("golden")
#  points      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :achievement do
    description { Faker::Lorem.paragraph(sentence_count: 2) }
    code        { %i[money_movement money_managed budget_reached].sample }
    level       { %i[silver golden diamond].sample }
    points      { rand(1..1000) }
  end
end
