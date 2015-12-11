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

FactoryGirl.define do
  factory :permission_acl, class: Permission::Acl do
    model  { %w('activity', 'client', 'person', 'person_technology', 'post').sample }
    action { %w('index', 'show', 'new', 'create', 'edit', 'update', 'delete').sample }
  end
end
