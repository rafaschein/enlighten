require 'rails_helper'

RSpec.describe Card::Person, type: :model do
  let(:current_user) { create(:user) }
  let(:person)       { create(:person) }

  subject { described_class.new(person, current_user) }

  describe '#path' do
    it 'receives path' do
      expect(subject.path).to eq('Pessoas')
    end
  end

  describe '#title' do
    it 'receives title' do
      expect(subject.title).to eq(person.name)
    end
  end

  describe '#informations' do
    context 'when have membership' do
      before { create(:project_member, person: person) }

      it 'receives array with informations' do
        expect(subject.informations).to have(2).items
      end
    end

    context 'when not have membership' do
      it 'receives empty array' do
        expect(subject.informations).to eq([])
      end
    end
  end
end
