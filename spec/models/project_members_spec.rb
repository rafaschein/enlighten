# == Schema Information
#
# Table name: project_members
#
#  id           :integer          not null, primary key
#  project_id   :integer
#  person_id    :integer
#  period_start :datetime
#  period_end   :datetime
#  function     :string
#

require 'rails_helper'

RSpec.describe ProjectMember, type: :model do
  it { expect(subject).to have_db_column(:id) }
  it { expect(subject).to have_db_column(:project_id) }
  it { expect(subject).to have_db_column(:person_id) }
  it { expect(subject).to have_db_column(:period_start) }
  it { expect(subject).to have_db_column(:period_end) }
  it { expect(subject).to have_db_column(:role_id) }

  it { expect(subject).to belong_to(:project) }
  it { expect(subject).to belong_to(:person) }
  it { expect(subject).to belong_to(:role) }

  it { expect(subject).to validate_presence_of(:project) }
  it { expect(subject).to validate_presence_of(:person) }
  it { expect(subject).to validate_presence_of(:role) }
  it { expect(subject).to validate_presence_of(:period_start) }

  describe 'period operations' do
    subject { create(:project_member, period_start: period_start, period_end: period_end) }
    let(:period_start) { Date.today - 3.months }

    describe '#period_end' do
      context 'period_end is empty' do
        let(:period_end) { nil }

        it { expect(subject.period).to eq(period_start..DateTime::Infinity.new) }
      end

      context 'period_end is set' do
        let(:period_end) { Date.today + 3.months }

        it { expect(subject.period).to eq(period_start..period_end) }
      end
    end

    describe '#current?' do
      context 'when NOW is in the range' do
        let(:period_start) { Date.today - 3.months }
        let(:period_end) { Date.today + 3.months }

        it { expect(subject.current?).to be(true) }
      end

      context 'when NOW is outside the range' do
        let(:period_start) { Date.today + 1.months }
        let(:period_end) { Date.today + 3.months }

        it { expect(subject.current?).to be(false) }
      end

      context 'when period_end is empty and NOW is in the range' do
        let(:period_start) { Date.today - 3.months }
        let(:period_end) { nil }

        it { expect(subject.current?).to be(true) }
      end
    end
  end
end
