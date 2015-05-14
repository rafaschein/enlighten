# == Schema Information
#
# Table name: project_members
#
#  id           :integer          not null, primary key
#  project_id   :integer
#  person_id    :integer
#  period_start :datetime
#  period_end   :datetime
#  function     :string
#

FactoryGirl.define do
  factory :person_technology, class: PersonTechnology do
    skill_rating { rand 1..5 }
  end
end
