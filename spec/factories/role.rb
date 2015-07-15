# == Schema Information
#
# Table name: roles
#
#  id            :integer          not null, primary key
#  name          :string
#

FactoryGirl.define do
  factory :role, class: Role do
    name { ['Developer', 'Quality analyst', 'Tech Lead', 'Business analyst', 'Project Manager'].sample }
    description { Faker::Lorem.paragraph(3) }
  end
end
