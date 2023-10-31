# frozen_string_literal: true

# == Schema Information
#
# Table name: budgets
#
#  id                   :bigint           not null, primary key
#  date_limit           :datetime
#  goals_price_cents    :integer          not null
#  goals_price_currency :string           default("BRL"), not null
#  objective_name       :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  user_id              :bigint           not null
#
# Indexes
#
#  index_budgets_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Budget, type: :model do
  describe 'Validations' do
    subject { build(:budget, user: create(:user)) }

    it { is_expected.to belong_to(:user).required }
    it { is_expected.to have_many(:transactions).dependent(:destroy) }
    it { is_expected.to validate_presence_of(:objective_name) }
    it { is_expected.to validate_uniqueness_of(:objective_name).scoped_to(:user_id) }
  end

  describe '#save' do
    context 'when title is empty' do
      let(:budget) { build(:budget, :invalid) }

      it 'should not be valid' do
        expect(budget.valid?).to be_falsey
        expect(budget.errors.messages[:user]).to           include 'é obrigatório(a)'
        expect(budget.errors.messages[:objective_name]).to include 'não pode ficar em branco'
        # expect(budget.errors.messages[:goals_price]).to    include 'deve ser maior ou igual a 1'
      end

      it 'should not save' do
        expect(budget.save).to be_falsey
      end
    end

    context 'when title is full' do
      let(:budget) { build(:budget) }

      it 'should be valid' do
        expect(budget.valid?).to be_truthy
      end

      it 'should be saved' do
        expect(budget.save).to be_truthy
      end
    end
  end
end
