require 'rails_helper'

RSpec.describe Person, type: :model do
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
end
