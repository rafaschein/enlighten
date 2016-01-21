require 'rails_helper'

RSpec.describe Card::Project, type: :model do
  let(:current_user) { create(:user) }
  let(:project)      { create(:project) }

  subject { described_class.new(project, current_user) }

  describe '#path' do
    it 'receives path' do
      expect(subject.path).to eq('Projetos')
    end
  end

  describe '#title' do
    it 'receives title' do
      expect(subject.title).to eq(project.name)
    end
  end

  describe '#subtitle' do
    context 'when have client' do
      let(:client) { create(:client) }

      before do
        project.client = client
        project.save
      end

      it 'receives subtitle' do
        expect(subject.subtitle).to eq(project.client.name)
      end
    end

    context 'when not have client' do
      it 'receives subtitle' do
        expect(subject.subtitle).to be_nil
      end
    end
  end

  describe '#informations' do
    it 'receives array with informations' do
      expect(subject.informations).to have(3).items
    end
  end
end
