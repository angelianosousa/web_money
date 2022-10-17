# == Schema Information
#
# Table name: notifications
#
#  id              :bigint           not null, primary key
#  recurrence_id   :bigint
#  user_profile_id :bigint
#  title           :string
#  description     :string
#  read            :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
FactoryBot.define do
  factory :notification do
    user_profile
    recurrence
    title { Faker::Restaurant.type }
    description { Faker::Restaurant.description }
    read { %i[true false].sample }
  end
end
