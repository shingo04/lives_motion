FactoryBot.define do
  factory :comment do
    comment { Faker::Movie.title }
    association :user
    association :tweet
  end
end
