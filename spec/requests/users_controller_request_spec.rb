require 'rails_helper'

describe 'UsersControler request spec', type: :request do
  describe 'GET#new' do
    subject { get sign_up_path }

    it 'should have http status 200' do
      subject

      expect(response).to have_http_status(200)
    end
  end

  describe 'POST#create' do
    let(:user_params) { attributes_for(:user, :unconfirmed) }

    subject { post sign_up_path, params: { user: user_params } }

    describe 'successful creation' do
      it 'should create a user' do
        expect {
          subject
        }.to change(User, :count).by(1)
      end

      it 'should have http status 302' do
        subject

        expect(response).to have_http_status(302)
      end
    end

    describe 'unsuccessful creation' do
      before do
        create(:user, phone_number: user_params[:phone_number])
      end

      it 'should not create a user' do
        expect {
          subject
        }.to change(User, :count).by(0)
      end

      it 'should have http status 200' do
        subject

        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'PATCH#update' do
    let(:user) { create(:user, :unconfirmed) }
    let(:user_params) { { confirmation_number: confirmation_number } }

    subject { patch user_path(user), params: { user: user_params } }

    describe 'successful update' do
      let(:confirmation_number) { user.confirmation_number }

      it 'should update the users confirmed attribute' do
        expect { subject }.to change { user.reload; user.confirmed }
      end

      it 'should have http status 302' do
        subject

        expect(response).to have_http_status(302)
      end
    end

    describe 'unsuccessful update' do
      let(:confirmation_number) { user.confirmation_number.reverse }

      it 'should not update the users confirmed attribute' do
        expect { subject }.not_to change{ user.reload; user.confirmed }
      end

      it 'should have http status 200' do
        subject

        expect(response).to have_http_status(200)
      end
    end
  end
end
