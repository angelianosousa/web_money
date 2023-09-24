# == Schema Information
#
# Table name: categories
#
#  id              :bigint           not null, primary key
#  category_type   :integer          default("recipe")
#  title           :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_profile_id :bigint
#
# Indexes
#
#  index_categories_on_user_profile_id  (user_profile_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_profile_id => user_profiles.id)
#
require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:user_profile) { create(:user_profile) }

  context 'Validations' do
    subject { build(:category) }

    it { is_expected.to belong_to(:user_profile).required }
    it { is_expected.to have_many(:transactions).dependent(:destroy) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_uniqueness_of(:title).scoped_to(:user_profile_id) }
    it { is_expected.to define_enum_for(:category_type) }
  end

  context '#save' do
    context 'when title is empty' do
      let(:category) { build(:category, user_profile: user_profile, title: '') }

      it 'should not be valid' do
        expect(category.valid?).to be_falsey
      end

      it 'should not save' do
        expect(category.save).to be_falsey
      end
    end

    context 'when title is full' do
      let(:category) { build(:category, user_profile: user_profile) }

      it 'should be valid' do
        expect(category.valid?).to be_truthy
      end

      it 'should be saved' do
        expect(category.save).to be_truthy
      end
    end
  end
end
