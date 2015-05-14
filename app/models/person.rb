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
#  image_id        :string
#

class Person < ActiveRecord::Base
  belongs_to :user
  has_many :memberships, class_name: ProjectMember.name
  has_many :technologies, class_name: PersonTechnology.name
  validates :name, presence: true
  attachment :image
end
