# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it { is_expected.to have_many(:transactions).dependent(:destroy) }
    it { is_expected.to have_many(:categories).dependent(:destroy) }
    it { is_expected.to have_many(:bills).dependent(:destroy) }
    it { is_expected.to have_many(:budgets).dependent(:destroy) }
    it { is_expected.to have_many(:accounts).dependent(:destroy) }
    it { is_expected.to have_many(:profile_achievements).dependent(:destroy) }
    it { is_expected.to have_many(:achievements).through(:profile_achievements) }
  end

  describe '#save' do
    describe 'Fail scenario' do
      let(:user) { build(:user, :invalid) }

      context 'when submit invalid attributes' do
        it 'should not be valid' do
          expect(user.valid?).to be_falsey
          expect(user.errors.messages[:email]).to include 'não pode ficar em branco'
          expect(user.errors.messages[:password]).to include 'não pode ficar em branco'
        end

        it 'should not save' do
          expect(user.save).to be_falsey
        end
      end
    end

    describe 'Success scenario' do
      context 'when submit valid attributes' do
        let(:user) { build(:user) }

        it 'shoud be valid' do
          expect(user.valid?).to be_truthy
        end

        it 'shoud be saved' do
          expect(user.save).to be_truthy
        end
      end
    end
  end

  describe '.building_profile' do
    let(:user) { create(:user) }

    it 'has a least 2 accounts by default' do
      expect(user.accounts.count).to eq(2)
    end

    it 'has a least 2 categories by default' do
      expect(user.categories.count).to eq(2)
    end

    it 'has counting achieve by default' do
      expect(user.profile_achievements.count).to eq(Achievement.count)
    end
  end
end
