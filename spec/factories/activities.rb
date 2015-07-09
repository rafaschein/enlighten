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

FactoryGirl.define do
  factory :activity do
    user_id { create(:user).id }
  end

end
