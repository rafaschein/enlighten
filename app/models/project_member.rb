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

class ProjectMember < ActiveRecord::Base
  belongs_to :project
  belongs_to :person
  belongs_to :role

  validates :project, presence: true
  validates :person, presence: true
  validates :role, presence: true
  validates :period_start, presence: true

  def period
    period_start..(period_end || DateTime::Infinity.new)
  end

  def current?
    # checks if now is in the period
    period.cover? Time.now
  end
end
