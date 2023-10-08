# frozen_string_literal: true

# == Schema Information
#
# Table name: user_profiles
#
#  id         :bigint           not null, primary key
#  name       :string           default("")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_user_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe UserProfile, type: :model do
  describe 'Validations' do
    it { is_expected.to belong_to(:user).required }
    it { is_expected.to have_many(:transactions).dependent(:destroy) }
    it { is_expected.to have_many(:categories).dependent(:destroy) }
    it { is_expected.to have_many(:accounts).dependent(:destroy) }
    it { is_expected.to have_many(:bills).dependent(:destroy) }
    it { is_expected.to have_many(:budgets).dependent(:destroy) }
    it { is_expected.to have_many(:achievements).dependent(:destroy) }
    it { is_expected.to have_many(:achievements).through(:profile_achievements) }
  end

  let(:user) { create(:user) }

  describe '#save' do
    context 'when title is empty' do
      let(:user_profile) { build(:user_profile, user: nil) }

      it 'should not be valid' do
        expect(user_profile.valid?).to be_falsey
      end

      it 'should not save' do
        expect(user_profile.save).to be_falsey
      end
    end

    context 'when title is full' do
      let(:user_profile) { build(:user_profile, user: user) }

      it 'should be valid' do
        expect(user_profile.valid?).to be_truthy
      end

      it 'should be saved' do
        expect(user_profile.save).to be_truthy
      end
    end
  end
end
