# frozen_string_literal: true

# == Schema Information
#
# Table name: notifications
#
#  id              :bigint           not null, primary key
#  description     :string
#  read            :boolean          default(FALSE)
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_profile_id :bigint
#
# Indexes
#
#  index_notifications_on_user_profile_id  (user_profile_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_profile_id => user_profiles.id)
#
FactoryBot.define do
  factory :notification do
    user_profile
    title { Faker::Restaurant.type }
    description { Faker::Restaurant.description }
    read { %i[true false].sample }
  end
end
