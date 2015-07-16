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

class SocialLink < ActiveRecord::Base
  belongs_to :person

  def self.available_providers
    configuration.map { |p| p[:provider].to_sym }
  end

  def url
    template = self.class.provider_url_configuration(provider)

    template.sub('#identifier', indentifier)
  end

  private

  def self.provider_url_configuration(provider)
    configuration.find { |i| i[:provider] == provider }[:url]
  end

  def self.configuration
    Rails.application.config_for(:social_links).map(&:symbolize_keys)
  end
end
