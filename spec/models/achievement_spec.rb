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
require 'rails_helper'

RSpec.describe Achievement, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
