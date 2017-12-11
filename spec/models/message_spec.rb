require 'spec_helper'
require 'rails_helper'

describe 'Message', type: :model do
  let(:user) { create(:user) }
  let(:channel) { create(:channel, user_id: user.id) }
  let(:message) { create(:message, user_id: user.id, channel_id: channel.id) }
  subject { message }

  describe 'validations' do
    it { should validate_presence_of(:content) }
    it { should validate_length_of(:content) }
  end

  describe '#is_edited?' do
    it 'should return false if the message has not been edited' do
      expect(message.is_edited?).to be(false)
    end

    it 'should return true if the message has been edited' do
      message.update!(content: 'This is my new message')
      expect(message.reload.is_edited?).to be(true)
    end
  end
end
