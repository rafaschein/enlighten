require 'rails_helper'

RSpec.describe CardSerializer, type: :serializer do
  let(:current_user) { build(:user) }
  let(:person)       { build(:person) }
  let(:card)         { Card::Person.new(person, current_user) }
  let(:serializer)   { described_class.new(card) }

  it 'receives interface keys' do
    expect(serializer.attributes).to include(:type)
    expect(serializer.attributes).to include(:path)
    expect(serializer.attributes).to include(:avatar)
    expect(serializer.attributes).to include(:title)
    expect(serializer.attributes).to include(:subtitle)
    expect(serializer.attributes).to include(:informations)
    expect(serializer.attributes).to include(:statistics)
    expect(serializer.attributes).to include(:links)
  end
end
