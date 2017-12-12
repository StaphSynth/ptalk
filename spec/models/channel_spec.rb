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

  describe '#authorized_contributor?' do
    let(:friendly_user) { create(:user) }
    let(:unfriendly_user) { create(:user) }

    context 'When channel set to private' do

      before do
        channel.update!(private: true)
        channel.reload
      end

      it 'allows its owner' do
        expect(channel.authorized_contributor?(user)).to be(true)
      end

      it 'only allows authorized private contributors' do
        channel.private_contributors << friendly_user

        expect(channel.authorized_contributor?(friendly_user)).to be(true)
        expect(channel.authorized_contributor?(unfriendly_user)).to be(false)
      end
    end

    context 'When channel set to public' do
      it 'allows all users' do
        expect(channel.authorized_contributor?(user)).to be(true)
        expect(channel.authorized_contributor?(friendly_user)).to be(true)
        expect(channel.authorized_contributor?(unfriendly_user)).to be(true)
      end
    end
  end
end
