# == Schema Information
#
# Table name: project_members
#
#  id           :integer          not null, primary key
#  project_id   :integer
#  person_id    :integer
#  period_start :date
#  period_end   :date
#  role_id      :integer
#

FactoryGirl.define do
  factory :project_member, class: ProjectMember do
    project { create :project }
    person { create :person }
    role { create :role }
    period_start { Date.today - 6.months }
  end
end
