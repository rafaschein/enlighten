# == Schema Information
#
# Table name: roles
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#

require 'rails_helper'

RSpec.describe Role, type: :model do
  it { expect(subject).to have_db_column(:id) }
  it { expect(subject).to have_db_column(:name) }
  it { expect(subject).to have_db_column(:description) }

  describe '#for_select' do
    before do
      expect(Role).to receive_message_chain(:select, :order).and_return(:result)
    end

    it { expect(Role.for_select).to eq(:result) }
  end
end
