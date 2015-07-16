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

FactoryGirl.define do
  factory :social_link do
    person { create :person }
    provider { Faker::Lorem.word }
    identifier { Faker::Internet.url }
  end

end
