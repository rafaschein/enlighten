# == Schema Information
#
# Table name: clients
#
#  id         :integer          not null, primary key
#  name       :string
#  website    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  image_id   :string
#

require 'rails_helper'

RSpec.describe Client, type: :model do
  it { expect(subject).to have_db_column(:id) }
  it { expect(subject).to have_db_column(:name) }
  it { expect(subject).to have_db_column(:website) }
  it { expect(subject).to have_db_column(:created_at) }
  it { expect(subject).to have_db_column(:updated_at) }

  it { expect(subject).to have_many(:projects) }
  it { expect(subject).to have_and_belong_to_many(:followers) }
  it { expect(subject).to have_and_belong_to_many(:likers) }

  it { expect(subject).to validate_presence_of(:name) }

  describe '#followers' do
    let(:client) { create :client }

    it 'user followed clients' do
      user = create :user

      user.followed_clients << client
      user.save
      user.reload
      client.reload

      expect(client.followers).to eq [user]
    end
  end

  describe '#likers' do
    let(:client) { create :client }

    it 'user liked clients' do
      user = create :user

      user.liked_clients << client
      user.save
      user.reload
      client.reload

      expect(client.likers).to eq [user]
    end
  end
end
