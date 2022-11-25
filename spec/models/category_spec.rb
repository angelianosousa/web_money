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
require 'rails_helper'

RSpec.describe Category, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
