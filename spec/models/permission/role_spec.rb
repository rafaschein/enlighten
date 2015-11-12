# == Schema Information
#
# Table name: permission_roles
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Permission::Role, type: :model do
  it { expect(subject).to have_db_column(:name) }

  it { expect(subject).to have_many(:permission_acls) }

  # it { expect(subject).to have_and_belong_to_many(:users) }
  # raises error because association convetion need role_id column, but is permission_role_id ????

  it { expect(subject).to validate_presence_of(:name) }

  describe '#create' do
    let(:permission_role) { create :permission_role }

    it 'create role without acls' do
      expect(permission_role.permission_acls).to be_empty
    end
  end

  describe '#acls' do
    let(:permission_role) { create :permission_role }
    subject(:create_acls) { create_list(:permission_acl, 5, permission_role_id: permission_role.id) }

    it 'can see acls from role' do
      permission_role
      create_acls
      expect(permission_role.permission_acls).to have(5).items
    end
  end
end
