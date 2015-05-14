# == Schema Information
#
# Table name: project_members
#
#  id           :integer          not null, primary key
#  project_id   :integer
#  person_id    :integer
#  period_start :date
#  period_end   :date
#  function     :string
#

class ProjectMember < ActiveRecord::Base
  belongs_to :project
  belongs_to :person

  validates :period_start, presence: true

  def period
    period_start..(period_end || DateTime::Infinity.new)
  end

  def current?
    # checks if now is in the period
    period.cover? Time.now
  end
end
