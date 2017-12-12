require 'spec_helper'
require 'rails_helper'
require 'clearance/rspec'

describe UsersController, type: :controller do
  let(:user) { create(:user) }

  describe '#index' do
    subject { get :index }

    describe 'When logged-in' do
      before { sign_in_as(user) }
      after { sign_out }

      it 'Renders the page' do
        subject
        expect(response).to be_successful
      end
    end

    describe 'When not logged-in' do
      it 'redirects to sign_in page' do
        subject
        expect(response).not_to be_successful
        expect(response.status).to be(302)
      end
    end
  end

  describe '#show' do
    subject { get :show, params: { id: user.id } }

    describe 'When logged-in' do
      before { sign_in_as(user) }
      after { sign_out }

      it 'Renders the page' do
        subject
        expect(response).to be_successful
      end
    end

    describe 'When not logged-in' do
      it 'redirects to sign_in page' do
        subject
        expect(response).not_to be_successful
        expect(response.status).to be(302)
      end
    end
  end
end
