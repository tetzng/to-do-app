FactoryBot.define do
  factory :task do
    name { "task_name" }
    description { "task_description" }
    status { "doing" }
    deadline { Time.current }
    priority { "high" }
  end
end
