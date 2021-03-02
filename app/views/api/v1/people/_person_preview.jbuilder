json.id person.id
json.name person.name
if person.planet.present?
  json.planet do
    json.name person.planet.name
  end
end