
FactoryBot.define do
  factory :starship do
    name { Faker::Movies::StarWars.vehicle }
  end
end
