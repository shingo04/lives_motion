FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    age                   { 21 }
    height                { 170 }
    weight                { 57 }
    bmr                   { 1567 }
    introduction          { "こんにちは" }
  end
end
