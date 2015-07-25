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

class ProjectScreenshot < ActiveRecord::Base
  has_paper_trail

  belongs_to :project

  attachment :image
end
