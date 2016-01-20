require 'rails_helper'

RSpec.describe Card::Client, type: :model do
  let(:current_user) { create(:user) }
  let(:client)       { create(:client) }

  subject { described_class.new(client, current_user) }

  describe '#path' do
    it 'receives path' do
      expect(subject.path).to eq("Clientes")
    end
  end

  describe '#title' do
    it 'receives title' do
      expect(subject.title).to eq(client.name)
    end
  end

  describe '#informations' do
    it 'receives array with informations' do
      expect(subject.informations).to have(1).items
    end
  end
end
