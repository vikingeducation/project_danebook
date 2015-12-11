require 'rails_helper'

describe SearchesController do
  let(:female){create(:female)}
  let(:user){create(:user, :gender => female)}

  describe 'GET #index' do
    context 'the user is logged in' do
      before do
        login(user)
        get :index, :q => user.name
      end

      it 'sets an instance variable to the name of the resource being searched' do
        expect(assigns(:resource)).to eq('users')
      end

      it 'sets an instance variable to the results of the search' do
        expect(assigns(:results)).to eq(User.search(user.name))
      end

      it 'sets an instance variable to the query string' do
        expect(assigns(:q)).to eq(user.name)
      end

      it 'renders the index view' do
        expect(response).to render_template :index
      end
    end

    context 'the user is logged out' do
      before do
        get :index
      end

      it 'redirects to signup path' do
        expect(response).to redirect_to signup_path
      end

      it 'sets an error flash' do
        expect(flash[:error]).to_not be_nil
      end
    end
  end
end

