FactoryBot.define do
  factory :task do
    name { "task_name" }
    description { "task_description" }
    status { "doing" }
    deadline { "" }
    priority { "high" }
  end
end
