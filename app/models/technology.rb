# == Schema Information
#
# Table name: technologies
#
#  id         :integer          not null, primary key
#  name       :string
#  website    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  image_id   :string
#

class Technology < ActiveRecord::Base
  has_and_belongs_to_many :projects,
                          join_table: :project_technologies,
                          class_name: Project.name
  has_many :skilled_people, class_name: PersonTechnology.name
  has_many :activities, -> { order(created_at: :desc) }, as: :activity_owner

  validates :name, presence: true
  
  attachment :image
end
