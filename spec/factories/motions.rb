FactoryBot.define do
  factory :motion do
    run      { 120 }
    abs      { 12 }
    squat    { 30 }
    push_ups { 12 }
    spine    { 25 }
    association :user
  end
end
