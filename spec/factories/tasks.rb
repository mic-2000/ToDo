# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    name { Faker::Lorem.sentence(3) }
    deadline Date.today + 5.days
    done false
    project
  end
end
