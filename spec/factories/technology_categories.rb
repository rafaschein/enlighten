# == Schema Information
#
# Table name: technology_categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :technology_category do
    name { Faker::Lorem.word }
  end
end
