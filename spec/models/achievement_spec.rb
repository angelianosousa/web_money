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
    it { is_expected.to define_enum_for(:level) }
    it { is_expected.to define_enum_for(:code) }
    it { is_expected.to validate_numericality_of(:points) }
    it { is_expected.to validate_presence_of(:description) }
  end

  describe '#save' do
    context 'when code or / and level is empty' do
      let(:achievement) { build(:achievement, :invalid) }

      it 'should not be valid' do
        expect(achievement.valid?).to be_falsey
        expect(achievement.errors.messages[:description]).to include 'não pode ficar em branco'
        expect(achievement.errors.messages[:code]).to        include 'não pode ficar em branco'
        expect(achievement.errors.messages[:level]).to       include 'não pode ficar em branco'
        expect(achievement.errors.messages[:points]).to      include 'não é um número'
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

  let(:achieve_money_managed_silver) { create(:achievement, level: :silver, code: :money_managed, points: 100) }
  let(:achieve_money_managed_golden) { create(:achievement, level: :golden, code: :money_managed, points: 1000) }
  let(:user) do
    create(:user) do |user|
      user.achievements = [achieve_money_managed_silver]
    end
  end

  describe '.finished?' do
    context 'check when a achievement was complete' do
      it 'achieve have to be marked as finished' do
        user.profile_achievements.find_by(achievement_id: achieve_money_managed_silver).update(points_reached: 100)

        expect(achieve_money_managed_silver.finished?(user)).to be_truthy
      end
    end
  end

  # describe '.previous_level_finished?' do
  #   context 'check when a achievement have previous level finished' do
  #     user.profile_achievements.find_by(achievement_id: achieve_money_managed_silver).update(points_reached: 100)

  #     expect(achieve_money_managed_golden.previous_level_finished?(user)).to be_truthy
  #   end
  # end
end
