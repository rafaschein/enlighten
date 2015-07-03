# == Schema Information
#
# Table name: activities
#
#  id                  :integer          not null, primary key
#  activity_owner_id   :integer
#  activity_owner_type :string
#  item_id             :integer
#  item_type           :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'rails_helper'

RSpec.describe Activity, type: :model do
  it { expect(subject).to have_db_column(:activity_owner_id) }
  it { expect(subject).to have_db_column(:activity_owner_type) }
  it { expect(subject).to have_db_column(:item_id) }
  it { expect(subject).to have_db_column(:item_type) }
  it { expect(subject).to have_db_column(:created_at) }
  it { expect(subject).to have_db_column(:updated_at) }

  it { expect(subject).to belong_to(:activity_owner) }
  it { expect(subject).to belong_to(:item) }
end
