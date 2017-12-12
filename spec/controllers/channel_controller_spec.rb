require 'spec_helper'
require 'rails_helper'
require 'clearance/rspec'

describe ChannelsController, type: :controller do
  let(:user) { create(:user) }
  let(:channel) { create(:channel, user_id: user.id) }

  describe '#index' do
    subject { get :index }

    context 'When logged in' do
      before { sign_in_as(user) }
      after { sign_out }

      it 'renders the index page' do
        subject
        expect(response).to be_successful
      end
    end

    context 'When not logged in' do
      it 'responds 302 forbidden' do
        subject
        expect(response).not_to be_successful
        expect(response.status).to be(302)
      end
    end
  end

  describe '#show' do
    subject { get :show, params: { id: channel.id } }

    context 'When logged in' do
      before { sign_in_as(user) }
      after { sign_out }

      it 'renders the show page' do
        subject
        expect(response).to be_successful
      end

      describe 'when trying to access unauthorized private channel' do
        let(:user_2) { create(:user) }
        let(:private_channel) { create(:channel, user_id: user_2.id, private: true) }

        it 'redirects to :index' do
          get :show, params: { id: private_channel.id }
          expect(response).not_to be_successful
          expect(response.status).to eq(302)
        end
      end
    end

    context 'When not logged in' do
      it 'returns 302 forbidden' do
        subject
        expect(response).not_to be_successful
        expect(response.status).to be(302)
      end
    end
  end
end
