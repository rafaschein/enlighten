# == Schema Information
#
# Table name: people
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  name            :string
#  github_account  :string
#  twitter_account :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryGirl.define do
  factory :person, class: Person do
    user_id { create(:user).id }
    name { Faker::Name.name }
    github_account { Faker::Lorem.word }
    twitter_account { Faker::Lorem.word }
  end

  factory :invalid_person, class: Person do
    user_id nil
    name ''
    github_account ''
    twitter_account ''
  end
end
