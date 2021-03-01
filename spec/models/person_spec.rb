require 'rails_helper'

RSpec.describe Person, type: :model do
  subject { create(:person) }
  describe '#name' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe '#birthday_year' do
    it { is_expected.to validate_presence_of(:birthday_year) }
  end

  describe '#height' do
    it { is_expected.to validate_presence_of(:height) }
  end

  describe '#mass' do
    it { is_expected.to validate_presence_of(:mass) }
  end

  describe '#planet' do
    it { is_expected.to belong_to(:planet) }
  end

  describe '#drived_transports' do
    it { is_expected.to have_many(:drived_transports) }
  end

  describe '#transports' do
    it { is_expected.to have_many(:transports).through(:drived_transports) }
  end

  context 'virtual fields' do
    let(:starship) { create(:starship) }
    let(:vehicle) { create(:vehicle) }

    before do
      DrivedTransport.create(person_id: subject.id, transport_id: starship.id)
      DrivedTransport.create(person_id: subject.id, transport_id: vehicle.id)
    end
    describe '.starships' do
      it { expect(subject.starships).to include(starship) }
      it { expect(subject.starships.map(&:type)).to_not include('Vehicle') }
    end

    describe '.vehicle' do
      it { expect(subject.vehicles).to include(vehicle) }
      it { expect(subject.vehicles.map(&:type)).to_not include('Starship') }
    end
  end


end
