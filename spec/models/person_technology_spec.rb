# == Schema Information
#
# Table name: person_technologies
#
#  id            :integer          not null, primary key
#  person_id     :integer
#  technology_id :integer
#  skill_rating  :integer          default(0), not null
#

require 'rails_helper'

RSpec.describe PersonTechnology, type: :model do
  it { expect(subject).to have_db_column(:id) }
  it { expect(subject).to have_db_column(:person_id) }
  it { expect(subject).to have_db_column(:technology_id) }
  it { expect(subject).to have_db_column(:skill_rating) }

  it { expect(subject).to belong_to(:person) }
  it { expect(subject).to belong_to(:technology) }
end
