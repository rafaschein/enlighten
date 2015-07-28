# == Schema Information
#
# Table name: person_technologies
#
#  id            :integer          not null, primary key
#  person_id     :integer
#  technology_id :integer
#  skill_rating  :integer          default(0), not null
#  certificated  :boolean
#

class PersonTechnology < ActiveRecord::Base
  has_paper_trail

  belongs_to :person
  belongs_to :technology

  validates :skill_rating, presence: true, inclusion: { in: 1..5 }
end
