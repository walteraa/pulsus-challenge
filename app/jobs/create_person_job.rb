# frozen_string_literal: true
require 'open-uri'

class CreatePersonJob < ApplicationJob
  def perform(person_params)
    return false if person_params.blank?

    planet_url = person_params['homeworld']

    Rails.logger.info("[CreatePersonJob] - Trying to create #{person_params['name']} ... ")
    person = Person.find_or_create_by(name: person_params['name']) do |person|
      person.birthday_year = person_params['birth_year']
      person.height = person_params['height']
      person.mass = person_params['mass']
    end

    Rails.logger.error("Failed to create person, errors => #{person.errors.full_messages}") unless person.valid?
    return person.errors unless person.valid?

    CreatePlanetAndAssignToPersonJob.perform_later(planet_url, person.id)
    create_vehicles(person_params, person)
    create_species(person_params, person)

    true # Just for debuggin on Sidekiq
  end

  private

  def create_vehicles(person_params, person)
    person_params['vehicles']&.each do |vehicle_url|
      CreateTransportAndAssignToPersonJob.perform_later(vehicle_url, 'Vehicle', person.id)
    end

    person_params['starships']&.each do |starship_url|
      CreateTransportAndAssignToPersonJob.perform_later(starship_url, 'Starship', person.id)
    end
  end

  def create_species(person_params, person)
    person_params['species']&.each do |species_url|
      CreateSpecieAndAssignToPersonJob.perform_later(species_url, person.id)
    end
  end
end
