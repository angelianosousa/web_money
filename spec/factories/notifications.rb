# frozen_string_literal: true

# == Schema Information
#
# Table name: notifications
#
#  id          :bigint           not null, primary key
#  description :string
#  read        :boolean          default(FALSE)
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_notifications_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :notification do
    user_id     { create(:user).id }
    title       { Faker::Restaurant.type }
    description { Faker::Restaurant.description }
    read        { false }

    trait :invalid do
      user_id     {}
      title       {}
      description {}
      read        {}
    end
  end
end
