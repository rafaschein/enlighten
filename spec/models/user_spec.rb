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
  it { expect(subject).to have_and_belong_to_many(:followed_technologies) }
  it { expect(subject).to have_and_belong_to_many(:followed_projects) }
  it { expect(subject).to have_and_belong_to_many(:followed_clients) }
  it { expect(subject).to have_and_belong_to_many(:followed_people) }
  it { expect(subject).to have_and_belong_to_many(:liked_technologies) }
  it { expect(subject).to have_and_belong_to_many(:liked_projects) }
  it { expect(subject).to have_and_belong_to_many(:liked_clients) }
  it { expect(subject).to have_and_belong_to_many(:liked_people) }

  describe '#projects' do
    let(:project) { create :project }

    it 'user followed projects' do
      user = create :user

      user.followed_projects << project
      user.save
      user.reload

      expect(user.followed_projects).to eq [project]
    end

    it 'user liked projects' do
      user = create :user

      user.liked_projects << project
      user.save
      user.reload

      expect(user.liked_projects).to eq [project]
    end
  end

  describe '#technologies' do
    let(:technology) { create :technology }

    it 'user followed technologies' do
      user = create :user

      user.followed_technologies << technology
      user.save
      user.reload

      expect(user.followed_technologies).to eq [technology]
    end

    it 'user liked technologies' do
      user = create :user

      user.liked_technologies << technology
      user.save
      user.reload

      expect(user.liked_technologies).to eq [technology]
    end
  end

  describe '#clients' do
    let(:client) { create :client }

    it 'user followed clients' do
      user = create :user

      user.followed_clients << client
      user.save
      user.reload

      expect(user.followed_clients).to eq [client]
    end

    it 'user liked clients' do
      user = create :user

      user.liked_clients << client
      user.save
      user.reload

      expect(user.liked_clients).to eq [client]
    end
  end

  describe '#people' do
    let(:person) { create :person }

    it 'user followed people' do
      user = create :user

      user.followed_people << person
      user.save
      user.reload

      expect(user.followed_people).to eq [person]
    end

    it 'user liked people' do
      user = create :user

      user.liked_people << person
      user.save
      user.reload

      expect(user.liked_people).to eq [person]
    end
  end
end
