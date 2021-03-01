class CreateSpecieAndAssignToPersonJob < ApplicationJob
  def perform(specie_url, person_id)
    result = Swapi::Client.new(specie_url).fetch

    species = Species.find_or_create_by(name: result['name']) do |species|
      species.height_avg = result['average_height']
    end


    PersonSpecies.create(person_id: person_id, species_id: species.id)
  end
end