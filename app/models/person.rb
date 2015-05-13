# == Schema Information
#
# Table name: people
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  name            :string
#  github_account  :string
#  twitter_account :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Person < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :projects,
                          join_table: :project_members,
                          foreign_key: :project_id,
                          class_name: Project.name

  validates :name, presence: true
  attachment :image
end
