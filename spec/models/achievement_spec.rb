require 'rails_helper'

RSpec.describe Achievement, type: :model do

  describe 'Validations' do
    subject { build(:achievement) }

    it { is_expected.to define_enum_for(:level) }
    it { is_expected.to define_enum_for(:code) }
    it { is_expected.to validate_numericality_of(:points_reached) }
    it { is_expected.to validate_numericality_of(:total_points) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to have_many(:profile_achievements) }
    it { is_expected.to have_many(:user_profiles).through(:profile_achievements) }
  end

  describe '#save' do
    context 'when title is empty' do
      let(:achievement) { build(:achievement, code: '', level: '') }

      it 'should not be valid' do
        expect(achievement.valid?).to be_falsey
      end

      it 'should not save' do
        expect(achievement.save).to be_falsey
      end
    end

    context 'when title is full' do
      let(:achievement) { build(:achievement) }

      it 'should be valid' do
        expect(achievement.valid?).to be_truthy
      end

      it 'should be saved' do
        expect(achievement.save).to be_truthy
      end
    end
  end

end
