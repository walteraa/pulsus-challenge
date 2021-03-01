# frozen_string_literal: true

require 'rails_helper'
require 'net/http'

RSpec.describe CreateSpecieAndAssignToPersonJob, type: :job do
  let(:person) { create(:person, planet: nil) }
  let(:swapi_species) { build(:swapi_species).stringify_keys }

  context 'A new species' do
    it 'crates planet and updates the person\'s planet' do
      allow(Net::HTTP).to receive(:get).and_return(swapi_species.to_json)
      expect { described_class.perform_now('https://localhost', person.id) }.to change {
        Species.count
      }.by(1).and change {
        person.reload.species.count
      }.by(1)
    end
  end

  context 'An existing species' do
    let(:species) { create(:species) }

    before { swapi_species['name'] = species.name }

    it 'updates the person\'s planet only' do
      allow(Net::HTTP).to receive(:get).and_return(swapi_species.to_json)
      expect { described_class.perform_now('https://localhost', person.id) }.to change {
        Species.count
      }.by(0).and change {
        person.reload.species.count
      }.by(1)
    end
  end
end