# == Schema Information
#
# Table name: bills
#
#  id              :bigint           not null, primary key
#  bill_type       :integer
#  due_pay         :date
#  price_cents     :decimal(, )
#  status          :integer          default("pending")
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_profile_id :bigint           not null
#
# Indexes
#
#  index_bills_on_user_profile_id  (user_profile_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_profile_id => user_profiles.id)
#
require 'rails_helper'

RSpec.describe Bill, type: :model do

  context 'Validations' do
    subject { build(:bill) }

    it { is_expected.to belong_to(:user_profile).required }
    it { is_expected.to have_many(:transactions).dependent(:destroy) }
    it { is_expected.to define_enum_for(:status) }
    it { is_expected.to define_enum_for(:bill_type) }
    it { is_expected.to validate_presence_of(:price_cents) }
    it { is_expected.to validate_presence_of(:due_pay) }
    it { is_expected.to validate_numericality_of(:price_cents) }
  end

  context '#save' do
    context 'when title is empty' do
      let(:bill) { build(:bill, title: '', due_pay: nil) }

      it 'should not be valid' do
        expect(bill.valid?).to be_falsey
      end

      it 'should not save' do
        expect(bill.save).to be_falsey
      end
    end

    context 'when title is full' do
      let(:bill) { build(:bill) }

      it 'should be valid' do
        expect(bill.valid?).to be_truthy
      end

      it 'should be saved' do
        expect(bill.save).to be_truthy
      end
    end
  end
end
