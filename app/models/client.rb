# == Schema Information
#
# Table name: clients
#
#  id         :integer          not null, primary key
#  name       :string
#  website    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  image_id   :string
#

class Client < ActiveRecord::Base
  has_many :projects
  validates :name, presence: true
  attachment :image
end
