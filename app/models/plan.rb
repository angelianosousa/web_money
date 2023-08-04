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
class Plan < ApplicationRecord
  belongs_to :user_profile
  has_many :tasks, dependent: :destroy

  accepts_nested_attributes_for :tasks
end
