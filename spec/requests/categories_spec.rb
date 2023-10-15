require 'rails_helper'

RSpec.describe "Categories", type: :request do
  let(:user)     { create(:user) }
  let(:category) { create(:category, user_profile: user.user_profile) }

  before do
    sign_in user
  end
  
  describe 'GET /categories' do

    it 'user logged acccess your categories screen' do
      get categories_path

      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /categories' do
    context 'Success Scenario' do
      let(:category_attributes) { attributes_for(:category) }

      it 'should save category with valid attributes' do
        params = { category: category_attributes }
        post categories_path, params: params

        expect(response).to have_http_status(302)
        expect(response).to redirect_to(categories_path)
        follow_redirect!
        expect(response.body).to include(I18n.t('categories.create.success'))
      end
    end

    context 'Fail Scenario' do
      let(:category_attributes_invalid) { attributes_for(:category, user_profile: user.user_profile, title: nil) }

      it 'should not save category with title empty' do
        params = { category: category_attributes_invalid }
        post categories_path, params: params

        expect(response).to have_http_status(302)
        expect(response).to redirect_to(categories_path)
      end
    end
  end

  describe 'GET /categories/:id' do
    it 'Getting category update form' do
      get edit_category_path(category)

      expect(response).to have_http_status(200)
    end
  end

  describe 'PATCH /categories/:id' do
    context 'Success Scenario' do
      let(:category_attributes) { attributes_for(:category, user_profile: user.user_profile) }

      it 'update category, should return success' do
        params = { category: category_attributes }
        put category_path(category), params: params

        expect(response).to have_http_status(302)
        expect(response).to redirect_to(categories_path)
        follow_redirect!
        expect(response.body).to include(I18n.t('categories.update.success'))
      end
    end

    context 'Fail Scenario' do
      let(:category_attributes_invalid) { attributes_for(:category, user_profile: user.user_profile, title: nil) }

      describe 'when given title, date or price_cents empty' do
        it 'should not save' do
          params = { category: category_attributes_invalid }
          put category_path(category), params: params

          expect(response).to have_http_status(302)
          expect(response).to redirect_to(edit_category_path(category))
        end
      end
    end
  end

  describe 'DESTROY /categories/:id' do
    it 'should delete category' do
      expect {
        delete category_path(category)
      }.to change(Category, :count).by(0)
      expect(response).to have_http_status(:redirect)
    end
  end
end
