FactoryBot.define do
  factory :bill do
    title { "MyString" }
    value { "9.99" }
    due_pay { "2022-12-25" }
    bill_type { 1 }
    status { 1 }
  end
end
