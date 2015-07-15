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

require 'rails_helper'

RSpec.describe User, type: :model do
  it { expect(subject).to have_db_column(:id) }
  it { expect(subject).to have_db_column(:email) }
  it { expect(subject).to have_db_column(:encrypted_password) }
  it { expect(subject).to have_db_column(:reset_password_token) }
  it { expect(subject).to have_db_column(:reset_password_sent_at) }
  it { expect(subject).to have_db_column(:remember_created_at) }
  it { expect(subject).to have_db_column(:sign_in_count) }
  it { expect(subject).to have_db_column(:current_sign_in_at) }
  it { expect(subject).to have_db_column(:last_sign_in_at) }
  it { expect(subject).to have_db_column(:current_sign_in_ip) }
  it { expect(subject).to have_db_column(:last_sign_in_ip) }
  it { expect(subject).to have_db_column(:created_at) }
  it { expect(subject).to have_db_column(:updated_at) }

  it { expect(subject).to have_one(:person) }
end
