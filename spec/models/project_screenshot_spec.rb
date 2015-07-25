# == Schema Information
#
# Table name: project_screenshots
#
#  id          :integer          not null, primary key
#  project_id  :integer
#  description :text
#  image_id    :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe ProjectScreenshot, type: :model do
  it { expect(subject).to have_db_column(:id) }
  it { expect(subject).to have_db_column(:project_id) }
  it { expect(subject).to have_db_column(:description) }
  it { expect(subject).to have_db_column(:image_id) }
  it { expect(subject).to have_db_column(:created_at) }
  it { expect(subject).to have_db_column(:updated_at) }

  it { expect(subject).to belong_to(:project) }
end
