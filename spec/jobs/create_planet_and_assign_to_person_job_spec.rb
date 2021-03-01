# frozen_string_literal: true

require 'rails_helper'
require 'net/http'

RSpec.describe CreatePlanetAndAssignToPersonJob, type: :job do
  let(:person) { create(:person, planet: nil) }
  let(:swapi_planet) { build(:swapi_planet).stringify_keys }

  context 'A new planet' do
    it 'crates planet and updates the person\'s planet' do
      allow(Net::HTTP).to receive(:get).and_return(swapi_planet.to_json)
      expect { described_class.perform_now('https://localhost', person.id) }.to change {
                                                                                  Planet.count
                                                                                }.by(1).and change {
                                                                                              person.reload.planet
                                                                                            }
    end
  end

  context 'An existing planet' do
    let(:planet) { create(:planet) }

    before { swapi_planet['name'] = planet.name }

    it 'updates the person\'s planet only' do
      allow(Net::HTTP).to receive(:get).and_return(swapi_planet.to_json)
      expect { described_class.perform_now('https://localhost', person.id) }.to change {
                                                                                  Planet.count
                                                                                }.by(0).and change {
                                                                                              person.reload.planet
                                                                                            }
    end
  end
end
