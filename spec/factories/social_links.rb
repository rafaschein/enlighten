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

FactoryGirl.define do
  factory :social_link do
    person { create :person }
    provider { Faker::Lorem.word }
    indentifier { Faker::Internet.url }
  end

end
