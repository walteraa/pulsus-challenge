require 'rails_helper'

RSpec.describe Species, type: :model do
  describe '#name' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe '#height_avg' do
    it { is_expected.to validate_presence_of(:height_avg) }
  end
end
