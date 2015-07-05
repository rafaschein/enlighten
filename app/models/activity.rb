# == Schema Information
#
# Table name: activities
#
#  id                  :integer          not null, primary key
#  activity_owner_id   :integer
#  activity_owner_type :string
#  item_id             :integer
#  item_type           :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :integer
#

class Activity < ActiveRecord::Base
  belongs_to :activity_owner, polymorphic: true
  belongs_to :item, polymorphic: true
  belongs_to :user

  validates :activity_owner, presence: true
  validates :item, presence: true
  validates :user, presence: true
end
