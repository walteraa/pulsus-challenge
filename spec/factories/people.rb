FactoryBot.define do
  factory :person do
    name { Faker::Movies::StarWars.character }
    height { Faker::Number.within(range: 10..300) }
    mass { Faker::Number.within(range: 1..300) }
    planet { create(:planet) }
    birthday_year { Faker::Number.hexadecimal(digits: 5) }
  end
end