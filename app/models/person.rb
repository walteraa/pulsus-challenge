class Person < ApplicationRecord
  include Presentable
  validates_presence_of :name, :birthday_year, :height, :mass

  belongs_to :planet
  has_many :drived_transports
  has_many :person_species
  has_many :species, through: :person_species, source: :species
  has_many :transports, through: :drived_transports, source: :transport

  scope :by_planet, ->(planet_name) { joins(:planet).where(planet: { name: planet_name }) }
  scope :by_starship, ->(starship_name) { joins(:transports).where(transports: { name: starship_name, type: 'Starship' }) }
  scope :by_vehicle, ->(vehicle_name) { joins(:transports).where(transports: { name: vehicle_name, type: 'Vehicle' }) }

  def starships
    transports.where(type: 'Starship')
  end

  def vehicles
    transports.where(type: 'Vehicle')
  end
end
