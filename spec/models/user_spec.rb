require 'spec_helper'
require 'rails_helper'

RSpec.describe 'User', type: :model do
  let(:user) { create(:user) }
  subject { user }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
  end
end
