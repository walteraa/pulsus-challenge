class PersonSpecies < ApplicationRecord
  belongs_to :person
  belongs_to :species
end
