# == Schema Information
#
# Table name: social_links
#
#  id          :integer          not null, primary key
#  person_id   :integer
#  provider    :string
#  indentifier :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class SocialLink < ActiveRecord::Base
  belongs_to :person
end
