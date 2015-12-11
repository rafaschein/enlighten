# == Schema Information
#
# Table name: permission_acls
#
#  id                 :integer          not null, primary key
#  model              :string
#  action             :string
#  permission_role_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

module Permission
  class Acl < ActiveRecord::Base
    has_paper_trail

    validates :model, presence: true
    validates :action, presence: true

    belongs_to :permission_role, class_name: Permission::Role.name, foreign_key: 'permission_role_id'

    def self.table_name_prefix
      'permission_acl_'
    end
  end
end
