# frozen_string_literal: true

# == Schema Information
#
# Table name: accounts
#
#  id              :bigint           not null, primary key
#  price_cents     :integer          default(0), not null
#  price_currency  :string           default("BRL"), not null
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_profile_id :bigint           not null
#
# Indexes
#
#  index_accounts_on_user_profile_id  (user_profile_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_profile_id => user_profiles.id)
#
require 'rails_helper'

RSpec.describe Account, type: :model do
  describe 'Validations' do
    it { is_expected.to belong_to(:user_profile).required }
    it { is_expected.to have_many(:transactions).dependent(:destroy) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_numericality_of(:price_cents) }
  end

  describe '#save' do
    describe 'Fail scenario' do
      let(:account) { build(:account, :invalid) }

      context 'when submit invalid attributes' do
        it 'should not be valid' do
          expect(account.valid?).to be_falsey
          expect(account.errors.messages[:user_profile]).to include 'é obrigatório(a)'
          expect(account.errors.messages[:price_cents]).to  include 'não é um número'
          expect(account.errors.messages[:title]).to        include 'não pode ficar em branco'
        end

        it 'should not save' do
          expect(account.save).to be_falsey
        end
      end
    end

    describe 'Success scenario' do
      context 'when submit valid attributes' do
        let(:account) { build(:account) }

        it 'shoud be valid' do
          expect(account.valid?).to be_truthy
        end

        it 'shoud be saved' do
          expect(account.save).to be_truthy
        end
      end
    end
  end
end
