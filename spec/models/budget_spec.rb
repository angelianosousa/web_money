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

  let(:achievement_money_managed)  { create(:achievement, level: :silver, code: :money_managed) }
  let(:achievement_money_movement) { create(:achievement, level: :silver, code: :money_movement) }
  let(:achievement_budget_reached) { create(:achievement, level: :silver, code: :budget_reached) }

  let(:user) do
    create(:user) do |u|
      u.achievements << [achievement_money_managed, achievement_money_movement, achievement_budget_reached]
    end
  end

  describe '#save' do
    context 'when title is empty' do
      let(:budget) { build(:budget, :invalid) }

      it 'should not be valid' do
        expect(budget.valid?).to be_falsey
        expect(budget.errors.messages[:user]).to           include 'é obrigatório(a)'
        expect(budget.errors.messages[:objective_name]).to include 'não pode ficar em branco'
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

  describe '#finished' do
    let(:budget) { create(:budget, user: user, goals_price: 100_00) }
    let(:transactions) { create_list(:transaction, 2, user: user, budget: budget, price: 50_00) }

    it 'return budget with 100 progress' do
      budget.reload
      transactions.first.reload

      budgets_finished = Budget.finished(user)
      expect(budgets_finished.count).to eq(1)
      expect(budgets_finished.first.progress).to eq(100)
      expect(budget.transactions.count).to eq(2)
    end

    let(:budget_unfineshed) { create(:budget, user: user, goals_price: 100_00) }

    it 'return zero budgets' do
      budgets_finished = Budget.finished(user)

      expect(budgets_finished.count.zero?).to be_truthy
    end
  end
end
