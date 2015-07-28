# == Schema Information
#
# Table name: roles
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#

class Role < ActiveRecord::Base
  has_paper_trail

  def self.for_select
    select(:id, :name).order(:name)
  end
end
