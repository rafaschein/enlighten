# == Schema Information
#
# Table name: roles
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#

class Role < ActiveRecord::Base
  def self.for_select
    select(:id, :name).order(:name)
  end
end
