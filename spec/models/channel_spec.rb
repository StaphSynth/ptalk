require 'spec_helper'
require 'rails_helper'

RSpec.describe 'Channel', type: :model do
  let(:user) { create(:user) }
  let(:channel) { create(:channel, user_id: user.id) }
  subject { channel }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_length_of(:name) }
  end

  describe '#is_private?' do
    it 'should return the value of the private param' do
      expect(channel.is_private?).to be(false)
      channel.update!(private: true)
      expect(channel.reload.is_private?).to be(true)
    end
  end

  describe '#is_public?' do
    it 'should return the inverse of the private param' do
      expect(channel.is_public?).to eq(!channel.is_private?)
    end
  end
end
