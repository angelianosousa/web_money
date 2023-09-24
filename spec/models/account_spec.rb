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
  let(:user_profile)    { create(:user_profile) }

  context 'Validations' do
    subject { build(:account) }

    it { is_expected.to belong_to(:user_profile).required }
    it { is_expected.to have_many(:transactions).dependent(:destroy) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_numericality_of(:price_cents) }
  end

  context '#save' do
    context 'when title is empty' do
      let(:account) { build(:account, title: '', user_profile: user_profile) }

      it 'should not be valid' do
        expect(account.valid?).to be_falsey
      end

      it 'should not save' do
        expect(account.save).to be_falsey
      end
    end

    context 'when title is full' do
      let(:account) { build(:account, user_profile: user_profile) }

      it 'shoud be valid' do
        expect(account.valid?).to be_truthy
      end

      it 'shoud be saved' do
        expect(account.save).to be_truthy
      end
    end
  end

end
