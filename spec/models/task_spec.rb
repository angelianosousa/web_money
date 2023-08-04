# == Schema Information
#
# Table name: tasks
#
#  id         :bigint           not null, primary key
#  done       :boolean          default(FALSE)
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  plan_id    :bigint           not null
#
# Indexes
#
#  index_tasks_on_plan_id  (plan_id)
#
# Foreign Keys
#
#  fk_rails_...  (plan_id => plans.id)
#
require 'rails_helper'

RSpec.describe Task, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
