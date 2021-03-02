require 'rails_helper'

RSpec.describe PersonSpecies, type: :model do
  describe '#person' do
    it { is_expected.to belong_to(:person) }
  end

  describe '#species' do
    it { is_expected.to belong_to(:species) }
  end
end
