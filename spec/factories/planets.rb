FactoryBot.define do
  factory :planet do
    name { Faker::Movies::StarWars.planet }
  end
end
