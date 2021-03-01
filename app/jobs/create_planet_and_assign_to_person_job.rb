class CreatePlanetAndAssignToPersonJob < ApplicationJob
  def perform(planet_url, person_id)
    result = Swapi::Client.new(planet_url).fetch

    planet = Planet.find_or_create_by(name: result['name'])

    person = Person.find(person_id)

    person.update(planet_id: planet.id)
  end
end