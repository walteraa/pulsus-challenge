json.id person.id
json.name person.name
json.birth_year person.birthday_year
json.height person.height
json.mass person.mass
json.phrase person.presentation_phrase
if person.planet.present?
  json.planet do
    json.id person.planet.id
    json.name person.planet.name
  end
end
json.species(person.species) do |specie|
  json.id specie.id
  json.name specie.name
end
json.vehicle(person.vehicles) do |vehicle|
  json.id vehicle.id
  json.name vehicle.name
end
json.starships(person.starships) do |starships|
  json.id starships.id
  json.name starships.name
end