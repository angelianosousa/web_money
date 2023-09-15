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
require 'rails_helper'

RSpec.describe Achievement, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
