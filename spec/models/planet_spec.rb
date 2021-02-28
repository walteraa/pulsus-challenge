require 'rails_helper'

RSpec.describe Planet, type: :model do
  describe '#name' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe '#people' do
    it { is_expected.to have_many(:people).dependent(:nullify) }
  end
end
