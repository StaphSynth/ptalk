require 'spec_helper'
require 'rails_helper'

RSpec.describe 'Channel', type: :model do
  let(:channel) { create(:channel) }
  subject { channel }
  
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe '#is_public?' do
    it 'should return the value of the public param' do
      expect(channel.is_public?).to be(true)
      channel.update!(public: false)
      expect(channel.reload.is_public?).to be(false)
    end
  end
end
