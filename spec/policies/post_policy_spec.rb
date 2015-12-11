require 'rails_helper'

RSpec.describe PostPolicy, type: :policy do
  describe 'receive inheritance by application policy' do
    it { expect(described_class).to be < ApplicationPolicy }
  end
end
