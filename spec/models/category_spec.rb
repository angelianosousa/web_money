# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id            :bigint           not null, primary key
#  category_type :integer          default("recipe"), not null
#  title         :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_categories_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'Validations' do
    subject { build(:category) }

    it { is_expected.to belong_to(:user).required }
    it { is_expected.to have_many(:transactions).dependent(:destroy) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_uniqueness_of(:title).scoped_to(:user_id) }
    it { is_expected.to define_enum_for(:category_type) }
  end

  describe '#save' do
    context 'when title is empty' do
      let(:category) { build(:category, :invalid) }

      it 'should not be valid' do
        expect(category.valid?).to be_falsey
        expect(category.errors.messages[:user]).to  include 'é obrigatório(a)'
        expect(category.errors.messages[:title]).to include 'não pode ficar em branco'
      end

      it 'should not save' do
        expect(category.save).to be_falsey
      end
    end

    context 'when title is full' do
      let(:category) { build(:category) }

      it 'should be valid' do
        expect(category.valid?).to be_truthy
      end

      it 'should be saved' do
        expect(category.save).to be_truthy
      end
    end
  end
end
