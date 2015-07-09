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
  has_many :activities, -> { order(created_at: :desc) }, as: :activity_owner

  accepts_nested_attributes_for :technologies

  validates :name, presence: true

  attachment :image

  # Returns the activities posted on the persons's timeline and posted by the
  # person's user on other timelines.
  def all_activities
    if user.present?
      Activity.where('(activity_owner_id = :activity_owner_id and activity_owner_type = :activity_owner_type) or user_id = :user_id',
                     activity_owner_id: id, activity_owner_type: self.class.name, user_id: user.id)
              .order(created_at: :desc)
    else
      activities
    end
  end
end
