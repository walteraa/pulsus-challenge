# frozen_string_literal: true

require 'rails_helper'
require 'net/http'

RSpec.describe CreateTransportAndAssignToPersonJob, type: :job do
  let(:person) { create(:person, planet: nil) }
  let(:swapi_transport) { build(:swapi_transport).stringify_keys }

  context 'A new transport' do
    context 'Starship' do
      it 'creates a new starship' do
        allow(Net::HTTP).to receive(:get).and_return(swapi_transport.to_json)
        expect { described_class.perform_now('http://localhost', 'Starship', person.id) }.to change {
          Starship.count
        }.by(1).and change{
          Vehicle.count
        }.by(0).and change {
          person.starships.count
        }.by(1).and change {
          person.vehicles.count
        }.by(0)
      end
    end

    context 'Vehicle' do
      it 'creates a new vehicle' do
        allow(Net::HTTP).to receive(:get).and_return(swapi_transport.to_json)
        expect { described_class.perform_now('http://localhost', 'Vehicle', person.id) }.to change {
          Vehicle.count
        }.by(1).and change{
          Starship.count
        }.by(0).and change {
          person.vehicles.count
        }.by(1).and change {
          person.starships.count
        }.by(0)
      end
    end
  end

  context 'An existing transport' do
    context 'Starship' do
      let(:starship) { create(:starship) }

      before { swapi_transport['name'] = starship.name }

      it 'creates a new starship' do
        allow(Net::HTTP).to receive(:get).and_return(swapi_transport.to_json)
        expect { described_class.perform_now('http://localhost', 'Starship', person.id) }.to change {
          Starship.count
        }.by(0).and change{
          Vehicle.count
        }.by(0).and change {
          person.starships.count
        }.by(1).and change {
          person.vehicles.count
        }.by(0)
      end
    end

    context 'Vehicle' do
      let(:vehicle) { create(:vehicle) }

      before { swapi_transport['name'] = vehicle.name }

      it 'creates a new vehicle' do
        allow(Net::HTTP).to receive(:get).and_return(swapi_transport.to_json)
        expect { described_class.perform_now('http://localhost', 'Vehicle', person.id) }.to change {
          Vehicle.count
        }.by(0).and change{
          Starship.count
        }.by(0).and change {
          person.vehicles.count
        }.by(1).and change {
          person.starships.count
        }.by(0)
      end
    end

  end
end
