# == Schema Information
#
# Table name: technology_categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TechnologyCategory < ActiveRecord::Base
end
