
FactoryBot.define do
  factory :vehicle do
    name { Faker::Movies::StarWars.vehicle }
  end
end
