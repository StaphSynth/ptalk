require 'faker'

FactoryBot.define do
  factory :channel do
    name Faker::Name.name
    public true
  end

  factory :user do
    name Faker::Name.name
    email Faker::Internet.email
    password Faker::Internet.password
  end
end
