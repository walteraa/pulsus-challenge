
FactoryBot.define do
  factory :swapi_people, class:Hash do
    results do
      (1..Faker::Number.within(range: 1..10)).map do
        {
          'name' => Faker::Movies::StarWars.character,
          'height' => Faker::Number.within(range: 10..300),
          'mass' => Faker::Number.within(range: 1..300),
          'homeworld' => 'http://swapi.dev/api/planets/1/',
          'vehicles' => %w[http://swapi.dev/api/vehicles/14/ http://swapi.dev/api/vehicles/30/],
          'starships' => %w[http://swapi.dev/api/starships/12/ http://swapi.dev/api/starships/22/]
        }
      end
    end

    initialize_with { attributes }
  end

  factory :swapi_planet, class:Hash do
    name { Faker::Movies::StarWars.planet }

    initialize_with { attributes }
  end

  factory :swapi_transport, class:Hash do
    name { Faker::Movies::StarWars.vehicle }

    initialize_with { attributes }
  end
end