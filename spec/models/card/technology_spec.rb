require 'rails_helper'

RSpec.describe Card::Technology, type: :model do
  let(:current_user) { create(:user) }
  let(:technology)   { create(:technology) }

  subject { described_class.new(technology, current_user) }

  describe '#path' do
    it 'receives path' do
      expect(subject.path).to eq("Conhecimentos")
    end
  end

  describe '#title' do
    it 'receives title' do
      expect(subject.title).to eq(technology.name)
    end
  end

  describe '#subtitle' do
    it 'receives subtitle' do
      expect(subject.subtitle).to eq(technology.category.name)
    end
  end

  describe '#informations' do
    it 'receives array with informations' do
      expect(subject.informations).to have(2).items
    end
  end
end
