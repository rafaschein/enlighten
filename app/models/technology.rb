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
    class_name: Project.name,
    join_table: :project_technologies

  has_many :skilled_people, class_name: PersonTechnology.name
  has_many :activities, -> { order(created_at: :desc) }, as: :activity_owner

  has_and_belongs_to_many :followers,
    class_name: User.name,
    join_table: :users_following_technologies

  has_and_belongs_to_many :likers,
    class_name: User.name,
    join_table: :users_liking_technologies

  validates :name, presence: true

  attachment :image
end
