# == Schema Information
#
# Table name: permission_roles
#
#  id         :integer          not null, primary key
#  name       :string
#  default    :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

module Permission
  class Role < ActiveRecord::Base
    has_paper_trail

    validates :name, presence: true

    has_many :permission_acls,
             class_name: Permission::Acl.name,
             foreign_key: 'permission_role_id'

    has_and_belongs_to_many :users,
                            class_name: User.name,
                            join_table: :users_permission_roles,
                            association_foreign_key: 'user_id'

    def self.table_name_prefix
      'permission_role_'
    end
  end
end
