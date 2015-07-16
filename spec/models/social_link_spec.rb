# == Schema Information
#
# Table name: social_links
#
#  id          :integer          not null, primary key
#  person_id   :integer
#  provider    :string
#  indentifier :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe SocialLink, type: :model do

  it { expect(subject).to have_db_column(:id) }
  it { expect(subject).to have_db_column(:person_id) }
  it { expect(subject).to have_db_column(:provider) }
  it { expect(subject).to have_db_column(:indentifier) }
  it { expect(subject).to have_db_column(:created_at) }
  it { expect(subject).to have_db_column(:updated_at) }

  it { expect(subject).to belong_to(:person) }
end
