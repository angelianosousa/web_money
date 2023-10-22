# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Budgets', type: :request do
  let(:user) { create(:user) }
  let(:budget) { create(:budget, user_profile: user.user_profile) }

  before do
    sign_in user
  end

  describe 'GET /budgets' do
    it 'user logged access your budgets screen' do
      get budgets_path

      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /budgets' do
    let(:budget_attributes) { attributes_for(:budget, user_profile: user.user_profile) }

    context 'Success Scenario' do
      it 'should save with valid attributes' do
        params = { budget: budget_attributes }
        post budgets_path, params: params

        expect(response).to have_http_status(302)
        expect(response).to redirect_to(budgets_path)
        follow_redirect!

        expect(response.body).to include(I18n.t('budgets.create.success'))
      end
    end

    context 'Fail Scenario' do
      let(:budget_attributes_invalid) do
        attributes_for(:budget, user_profile: user.user_profile, objective_name: nil, date_limit: nil,
                                goals_price_cents: -1)
      end

      it 'should not save with objective_name, date_limit or goals_price_cents invalid' do
        params = { budget: budget_attributes_invalid }
        post budgets_path, params: params

        expect(response).to have_http_status(302)
        expect(response).to redirect_to(budgets_path)
      end
    end
  end

  describe 'PUT | PATCH /budgets/:id' do
    context 'Success Scenario' do
      let(:budget_attributes) { attributes_for(:budget, user_profile: user.user_profile) }

      it 'update budget, should return success' do
        params = { budget: budget_attributes }
        put budget_path(budget), params: params

        expect(response).to have_http_status(302)
        expect(response).to redirect_to(budgets_path)
        follow_redirect!
        expect(response.body).to include(I18n.t('budgets.update.success'))
      end
    end

    context 'Fail Scenario' do
      let(:budget_attributes_invalid) do
        attributes_for(:budget, user_profile: user.user_profile, objective_name: nil, date_limit: nil,
                                goals_price_cents: -1)
      end

      describe 'when given objective_name, date_limit or goals_price_cents invalid' do
        it 'should not save' do
          params = { budget: budget_attributes_invalid }
          put budget_path(budget), params: params

          expect(response).to have_http_status(302)
          expect(response).to redirect_to(edit_budget_url(budget))
        end
      end
    end
  end

  describe 'DELETE /budgets/:id' do
    it 'should delete budget' do
      expect do
        delete budget_path(budget)
      end.to change(Budget, :count).by(0)
      expect(response).to have_http_status(:redirect)
      follow_redirect!
      expect(response.body).to include(I18n.t('budgets.destroy.success'))
    end
  end
end
