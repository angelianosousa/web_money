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
FactoryBot.define do
  factory :task do
    name { "MyString" }
    done { false }
    plan { nil }
  end
end
