# frozen_string_literal: true

# == Schema Information
#
# Table name: achievements
#
#  id          :bigint           not null, primary key
#  code        :integer
#  description :string
#  level       :integer          default("golden")
#  points      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe Achievement, type: :model do
  describe 'Validations' do
    subject { build(:achievement) }

    it { is_expected.to define_enum_for(:level) }
    it { is_expected.to define_enum_for(:code) }
    it { is_expected.to validate_numericality_of(:points) }
    it { is_expected.to validate_presence_of(:description) }
  end

  describe '#save' do
    context 'when code or / and level is empty' do
      let(:achievement) { build(:achievement, code: '', level: '') }

      it 'should not be valid' do
        expect(achievement.valid?).to be_falsey
      end

      it 'should not save' do
        expect(achievement.save).to be_falsey
      end
    end

    context 'when code and level is full' do
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
