# frozen_string_literal: true

# == Schema Information
#
# Table name: notifications
#
#  id              :bigint           not null, primary key
#  description     :string
#  read            :boolean          default(FALSE)
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_profile_id :bigint
#
# Indexes
#
#  index_notifications_on_user_profile_id  (user_profile_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_profile_id => user_profiles.id)
#
require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to belong_to(:user_profile) }
  end

  describe '#save' do
    context 'when title is empty' do
      let(:notification) { build(:notification, :invalid) }

      it 'should not be valid' do
        expect(notification.valid?).to be_falsey
        expect(notification.errors.messages[:user_profile]).to include 'é obrigatório(a)'
        expect(notification.errors.messages[:description]).to  include 'não pode ficar em branco'
        expect(notification.errors.messages[:title]).to        include 'não pode ficar em branco'
      end

      it 'should not save' do
        expect(notification.save).to be_falsey
      end
    end

    context 'when title is full' do
      let(:notification) { build(:notification) }

      it 'should be valid' do
        expect(notification.valid?).to be_truthy
      end

      it 'should be saved' do
        expect(notification.save).to be_truthy
      end
    end
  end
end
