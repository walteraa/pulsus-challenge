FactoryBot.define do
  factory :species do
    name { Faker::Movies::StarWars.specie }
    height_avg { Faker::Number.within(range: 10..300) }
  end
end
