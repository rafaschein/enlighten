# == Schema Information
#
# Table name: social_links
#
#  id         :integer          not null, primary key
#  person_id  :integer
#  provider   :string
#  identifier :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe SocialLink, type: :model do

  it { expect(subject).to have_db_column(:id) }
  it { expect(subject).to have_db_column(:person_id) }
  it { expect(subject).to have_db_column(:provider) }
  it { expect(subject).to have_db_column(:identifier) }
  it { expect(subject).to have_db_column(:created_at) }
  it { expect(subject).to have_db_column(:updated_at) }

  it { expect(subject).to belong_to(:person) }

  describe '.available_providers' do
    subject { SocialLink.available_providers }

    before do
      allow(Rails.application).to receive(:config_for).and_return([{"provider"=>"github", "url"=>"https://github.com/\#{identifier}"}, {"provider"=>"twitter", "url"=>"https://twitter.com/\#{identifier}"}])
    end

    it { expect(subject).to eq [:github, :twitter] }
  end

  describe '#url' do
    subject { create :social_link, provider: 'github', identifier: 'CWISoftware' }

    it { expect(subject.url).to eq('https://github.com/CWISoftware') }
  end
end
