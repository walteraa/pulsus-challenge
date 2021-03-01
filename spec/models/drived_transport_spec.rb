require 'rails_helper'

RSpec.describe DrivedTransport, type: :model do
  describe '#person' do
    it { is_expected.to belong_to(:person) }
  end

  describe '#transport' do
    it { is_expected.to belong_to(:transport) }
  end
end
