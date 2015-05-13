# == Schema Information
#
# Table name: clients
#
#  id         :integer          not null, primary key
#  name       :string
#  website    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  image_id   :string
#

FactoryGirl.define do
  factory :client, class: Client do
    name { Faker::Company.name }
    website { Faker::Internet.url }
  end

  factory :invalid_client, class: Client do
    name ''
    website ''
  end
end
