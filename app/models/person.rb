class Person < ApplicationRecord
  validates_presence_of :name, :birthday_year, :height, :mass

  belongs_to :planet
  has_many :drived_transports
  has_many :person_species
  has_many :species, through: :person_species, source: :species
  has_many :transports, through: :drived_transports, source: :transport

  def starships
    transports.where(type: 'Starship')
  end

  def vehicles
    transports.where(type: 'Vehicle')
  end
end
