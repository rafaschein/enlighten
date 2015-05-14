# == Schema Information
#
# Table name: technologies
#
#  id         :integer          not null, primary key
#  name       :string
#  website    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  image_id   :string
#

require 'rails_helper'

RSpec.describe Technology, type: :model do
  it { expect(subject).to have_db_column(:id) }
  it { expect(subject).to have_db_column(:name) }
  it { expect(subject).to have_db_column(:website) }
  it { expect(subject).to have_db_column(:created_at) }
  it { expect(subject).to have_db_column(:updated_at) }

  it { expect(subject).to have_and_belong_to_many(:projects) }

  describe '#projects' do
    it 'associates technology projects' do
      technology = create :technology
      project = create :project

      technology.projects << project
      technology.save
      technology.reload

      expect(technology.projects).to eq [project]
    end
  end

  describe '#skilled_people' do
    it 'associates person with technology' do
      technology = create :technology
      person_technology = create :person_technology, person: create(:person)

      technology.skilled_people << person_technology
      technology.save
      technology.reload

      expect(technology.skilled_people).to eq [person_technology]
    end
  end
end
