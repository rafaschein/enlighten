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

require 'rails_helper'

RSpec.describe Permission::Acl, type: :model do
  it { expect(subject).to have_db_column(:model) }
  it { expect(subject).to have_db_column(:action) }

  it { expect(subject).to belong_to(:permission_role) }

  it { expect(subject).to validate_presence_of(:model) }
  it { expect(subject).to validate_presence_of(:action) }
end
