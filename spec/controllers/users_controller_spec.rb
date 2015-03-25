require 'rails_helper'

describe UsersController do
  let(:user){FactoryGirl.create(:user)}

  context 'guest access' do
    describe 'GET #new' do
      it 'assigns a new user' do
        get :new
        expect(assigns(:user)).to be_a_new(User)
      end

      it 'builds a new profile' do
        get :new
        expect(assigns(:profile)).to be_a_new(Profile)
      end
    end

    describe 'GET #index' do
      it 'redirects to login' do
        expect(get :index).to redirect_to(login_url)
      end
    end

    describe 'GET #show/:id' do
      it 'redirects to login' do
        get :show, id: FactoryGirl.create(:user).id
        expect(response).to redirect_to(login_url)
      end
    end

  end


  context 'user logged in' do
    before(:each) do
      #sneaky way to log in a user
      @current_user = FactoryGirl.create(:user)
      cookies[:auth_token] = @current_user.auth_token
    end

    describe 'GET #new' do
      it 'does not show the login page' do
        get :new
        expect(response).not_to render_template(:new)
      end

      it 'redirects to the user show page' do
        expect(get :new).to redirect_to(user_url(@current_user))
      end
    end

    describe 'GET #show/:id' do
      it 'redirects to a user\'s timeline' do
        get :show, id: user.id
        expect(response).to redirect_to(user_timeline_url(user))
      end

      it 'assigns @user by user_id' do
        get :show, id: user.id
        expect(assigns(:user)).to eq user
      end
    end

    describe 'GET #index (search page)' do
      it 'renders the index page' do
        expect(get :index).to render_template(:index)
      end

      context 'with an empty query' do
        it 'leaves @users empty' do
          get :index
          expect(assigns(:users)).to be_empty
        end
      end



      # the search query method is already fully tested
      # this JUST needs to check whether it is called
      # and whether it assigns its results to an instance variable
      context 'with a query that returns users' do
        before(:each) do
          allow(User).to receive(:search).
                          with("Gimme Everybody").
                          and_return(User.all)
        end

        it 'assigns the found users to the @users' do
          query = "Gimme Everybody"
          get :index, query: query
          expect(assigns(:users)).to eq User.search(query)
        end

        it 'calls the .search method with query' do
          query = "Gimme Everybody"
          expect(User).to receive(:search).with(query)
          get :index, query: query
        end
      end
    end

  end





end