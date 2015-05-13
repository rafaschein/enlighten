# == Schema Information
#
# Table name: projects
#
#  id            :integer          not null, primary key
#  name          :string
#  description   :string
#  scm_type      :string
#  scm_reference :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  image_id      :string
#

FactoryGirl.define do
  factory :project, class: Project do
    name { Faker::App.name }
    description { Faker::Lorem.paragraph(3) }
    scm_type 'git'
    scm_reference 'https://github.com/xxx/yyy'
  end

  factory :invalid_project, class: Project do
    name ''
    description ''
    scm_type ''
    scm_reference ''
  end
end
