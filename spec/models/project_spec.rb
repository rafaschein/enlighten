# == Schema Information
#
# Table name: projects
#
#  id            :integer          not null, primary key
#  name          :string
#  description   :text
#  scm_type      :string
#  scm_reference :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  image_id      :string
#  client_id     :integer
#

require 'rails_helper'

RSpec.describe Project, type: :model do
  it { expect(subject).to have_db_column(:id) }
  it { expect(subject).to have_db_column(:client_id) }
  it { expect(subject).to have_db_column(:name) }
  it { expect(subject).to have_db_column(:description) }
  it { expect(subject).to have_db_column(:scm_type) }
  it { expect(subject).to have_db_column(:scm_reference) }
  it { expect(subject).to have_db_column(:created_at) }
  it { expect(subject).to have_db_column(:updated_at) }

  it { expect(subject).to belong_to(:client) }
  it { expect(subject).to have_many(:members) }
  it { expect(subject).to have_many(:screenshots) }
  it { expect(subject).to have_and_belong_to_many(:technologies) }
  it { expect(subject).to have_and_belong_to_many(:followers) }
  it { expect(subject).to have_and_belong_to_many(:likers) }

  it { expect(subject).to validate_presence_of(:name) }

  describe '#members' do
    it 'associates project members' do
      project = create :project
      member = create :project_member, person: create(:person)

      project.members << member
      project.save
      project.reload

      expect(project.members).to eq [member]
    end
  end

  describe '#screenshots' do
    it 'associates project screenshots' do
      project = create :project
      screenshot = create :project_screenshot

      project.screenshots << screenshot
      project.save
      project.reload

      expect(project.screenshots).to eq [screenshot]
    end
  end

  describe '#technologies' do
    it 'associates project technologies' do
      project = create :project
      technology = create :technology

      project.technologies << technology
      project.save
      project.reload

      expect(project.technologies).to eq [technology]
    end
  end

  describe '#activities' do
    let(:project) { create :project }

    it 'associates person activities in decrescent publish order' do
      posts_a = create(:post)
      posts_b = create(:post)

      project.activities.create item: posts_a, user: create(:user)
      project.activities.create item: posts_b, user: create(:user)

      project.reload

      expect(project.activities).to have(2).items

      expect(project.activities.first.item).to eq posts_b
      expect(project.activities.second.item).to eq posts_a
    end
  end

  describe '#followers' do
    let(:project) { create :project }

    it 'user followed project' do
      user = create :user

      user.followed_projects << project
      user.save
      user.reload
      project.reload

      expect(project.followers).to eq [user]
    end
  end

  describe '#likers' do
    let(:project) { create :project }

    it 'user liked project' do
      user = create :user

      user.liked_projects << project
      user.save
      user.reload
      project.reload

      expect(project.likers).to eq [user]
    end
  end
end
