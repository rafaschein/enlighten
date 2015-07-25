# == Schema Information
#
# Table name: project_screenshots
#
#  id          :integer          not null, primary key
#  project_id  :integer
#  description :text
#  image_id    :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :project_screenshot do
    description { Faker::Lorem.paragraph(3) }
  end

end
