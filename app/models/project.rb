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
#

class Project < ActiveRecord::Base
  has_and_belongs_to_many :members,
                          join_table: :project_members,
                          foreign_key: :person_id,
                          class_name: Person.name
  validates :name, presence: true
  attachment :image
end
