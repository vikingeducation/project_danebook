require 'rails_helper'


describe FriendsController do


  describe 'POST #create' do

    let(:initiator) { create(:user) }
    let(:recipient) { create(:user) }

    before do
      request.cookies[:auth_token] = initiator.auth_token
    end

    context 'when prior page was part of this app' do

      it 'redirects to prior page' do
        prior_page = user_url(recipient)
        request.env["HTTP_REFERER"] = prior_page

        post :create, user_id: initiator.id, recipient_id: recipient.id

        expect(response).to redirect_to prior_page
      end

    end


    context 'when prior page was external to this app' do

      it 'redirects to appropriate page within this app' do
        prior_page = 'http://www.google.com'
        request.env["HTTP_REFERER"] = prior_page

        post :create, user_id: initiator.id, recipient_id: recipient.id

        expect(response).to redirect_to user_path(recipient)
      end

    end


  end


end