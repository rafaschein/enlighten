# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime
#  updated_at             :datetime
#

class User < ActiveRecord::Base
  has_paper_trail

  devise :database_authenticatable,
         :rememberable, :trackable

  has_one :person

  has_and_belongs_to_many :followed_projects,
                          class_name: Project.name,
                          join_table: :users_following_projects

  has_and_belongs_to_many :followed_technologies,
                          class_name: Technology.name,
                          join_table: :users_following_technologies

  has_and_belongs_to_many :followed_clients,
                          class_name: Client.name,
                          join_table: :users_following_clients

  has_and_belongs_to_many :followed_people,
                          class_name: Person.name,
                          join_table: :users_following_people

  has_and_belongs_to_many :liked_projects,
                          class_name: Project.name,
                          join_table: :users_liking_projects

  has_and_belongs_to_many :liked_technologies,
                          class_name: Technology.name,
                          join_table: :users_liking_technologies

  has_and_belongs_to_many :liked_clients,
                          class_name: Client.name,
                          join_table: :users_liking_clients

  has_and_belongs_to_many :liked_people,
                          class_name: Person.name,
                          join_table: :users_liking_people
end
