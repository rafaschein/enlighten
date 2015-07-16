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

  let(:yml_configuration) do
    [
      { 'provider' => 'github', 'url' => 'https://github.com/#identifier' },
      { 'provider' => 'twitter', 'url' => 'https://twitter.com/#identifier' }
    ]
  end

  describe '.available_providers' do
    subject { SocialLink.available_providers }

    before do
      allow(Rails.application).to receive(:config_for) { yml_configuration }
    end

    it { expect(subject).to eq [:github, :twitter] }
  end

  describe '.provider_url_configuration' do
    subject { SocialLink.provider_url_configuration(provider) }

    before do
      allow(Rails.application).to receive(:config_for).and_return(yml_configuration)
    end

    context 'when provider is github' do
      let(:provider) { 'github' }

      it { expect(subject).to eq 'https://github.com/#identifier' }
    end

    context 'when provider is twitter' do
      let(:provider) { 'twitter' }

      it { expect(subject).to eq 'https://twitter.com/#identifier' }
    end
  end

  describe '.configuration' do
    subject { SocialLink.configuration }

    before do
      allow(Rails.application).to receive(:config_for).and_return(yml_configuration)
    end

    it do
      expect(subject). to eq([
        { provider: 'github', url: 'https://github.com/#identifier' },
        { provider: 'twitter', url: 'https://twitter.com/#identifier' }
      ])
    end
  end

  describe '#url' do
    subject { create :social_link, provider: 'github', identifier: 'CWISoftware' }

    before do
      allow(Rails.application).to receive(:config_for).and_return(yml_configuration)
    end

    it { expect(subject.url).to eq('https://github.com/CWISoftware') }
  end

  describe 'social link icons' do
    it 'has all configured social links icons' do
      SocialLink.available_providers.each do |provider|
        expect(Rails.root.join('app', 'assets', 'images', 'social', "#{provider}.png")).to exist
      end
    end
  end
end
