# frozen_string_literal: true

require 'rails_helper'
require './app/services/count_achieve_points'

RSpec.describe CountAchievePoints do
  let(:achievement_money_managed)  { create(:achievement, level: :silver, code: :money_managed) }
  let(:achievement_money_movement) { create(:achievement, level: :silver, code: :money_movement) }
  let(:achievement_budget_reached) { create(:achievement, level: :silver, code: :budget_reached) }

  let(:user) do
    create(:user) do |user|
      user.achievements = [achievement_money_managed, achievement_money_movement, achievement_budget_reached]
    end
  end
  let(:bill) { create(:bill, user: user) }
  let(:transaction) { create(:transaction, user: user, bill: bill, price_cents: bill.price_cents) }

  describe '#call' do
    describe 'Count points for achievement money managed' do
      let(:points_for_money_managed) { CountAchievePoints.call(user, :money_managed) }

      it 'achieve money managed must had 10 points reached' do
        expect(points_for_money_managed.points_reached).to eq(10)
      end
    end

    describe 'Count points for achievement money movement' do
      let(:points_for_money_movement) { CountAchievePoints.call(user, :money_movement) }

      it 'achieve money movement must had 10 points reached' do
        expect(points_for_money_movement.points_reached).to eq(10)
      end
    end

    describe 'Count points for achievement budget reached' do
      let(:points_for_budget_reached) { CountAchievePoints.call(user, :budget_reached) }

      it 'achieve budget reached must had 10 points reached' do
        expect(points_for_budget_reached.points_reached).to eq(100)
      end
    end
  end
end
