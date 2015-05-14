# == Schema Information
#
# Table name: people
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  name            :string
#  github_account  :string
#  twitter_account :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  image_id        :string
#

require 'rails_helper'

RSpec.describe Person, type: :model do
  it { expect(subject).to have_db_column(:id) }
  it { expect(subject).to have_db_column(:user_id) }
  it { expect(subject).to have_db_column(:name) }
  it { expect(subject).to have_db_column(:github_account) }
  it { expect(subject).to have_db_column(:twitter_account) }
  it { expect(subject).to have_db_column(:created_at) }
  it { expect(subject).to have_db_column(:updated_at) }

  it { expect(subject).to have_many(:memberships) }

  describe '#projects' do
    it 'associates person projects' do
      person = create :person
      membership = create :project_member, project: create(:project)

      person.memberships << membership
      person.save
      person.reload

      expect(person.memberships).to eq [membership]
    end
  end

  describe '#technologies' do
    it 'associates person technologies' do
      person = create :person
      person_technology = create :person_technology, technology: create(:technology)

      person.technologies << person_technology
      person.save
      person.reload

      expect(person.technologies).to eq [person_technology]
    end
  end
end
