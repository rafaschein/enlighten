require 'rails_helper'

RSpec.describe 'social_links.yml' do
  describe 'social link icons' do
    subject { Rails.application.config_for(:social_links) }

    it 'has all configured social links icons' do
      subject.each do |provider_definition|
        expect(Rails.root.join('app', 'assets', 'images', 'social', "#{provider_definition['provider']}.png")).to exist
      end
    end
  end
end
