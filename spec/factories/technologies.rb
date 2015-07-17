# == Schema Information
#
# Table name: technologies
#
#  id                     :integer          not null, primary key
#  name                   :string
#  website                :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  image_id               :string
#  technology_category_id :integer
#

FactoryGirl.define do
  factory :technology, class: Technology do
    name { Faker::Lorem.word }
    website { Faker::Internet.url }
    category { create :technology_category }
  end

  factory :invalid_technology, class: Technology do
    name ''
    website ''
  end
end
