# == Schema Information
#
# Table name: projects
#
#  id            :integer          not null, primary key
#  name          :string
#  description   :string
#  scm_type      :string
#  scm_reference :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe Project, type: :model do
  it { expect(subject).to have_db_column(:id) }
  it { expect(subject).to have_db_column(:name) }
  it { expect(subject).to have_db_column(:description) }
  it { expect(subject).to have_db_column(:scm_type) }
  it { expect(subject).to have_db_column(:scm_reference) }
  it { expect(subject).to have_db_column(:created_at) }
  it { expect(subject).to have_db_column(:updated_at) }

  it { expect(subject).to have_and_belong_to_many(:members) }

  describe '#members' do
    it 'associates project members' do
      project = create :project
      person = create :person

      project.members << person
      project.save
      project.reload

      expect(project.members).to eq [person]
    end
  end
end
