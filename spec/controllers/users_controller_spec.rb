require 'rails_helper'

describe UsersController do
  let!(:user) { build(:user) }
  let(:creating_user) {

    post :create, user: {
      first_name: user.profile.first_name,
      last_name: user.profile.last_name,
      email: user.email,
      password: user.password,
      password_confirmation: user.password }

  }
  let(:invalid_creating_user) {

    post :create, user: {
      first_name: "",
      last_name: "",
      email: "",
      password: "",
      password_confirmation: "" }

  }
  let(:logging_in_user) {

    session[:user_id] = user.id

  }

  describe '#new' do

    it 'assigns the user instance variable' do

      get :new

      expect(assigns(:user)).to be_a(User)

    end

    it 'renders the new template' do

      get :new

      expect(response).to render_template(:new)

    end

  end

  describe '#create' do

    it 'assigns the user instance variable' do

      post :create, user: { first_name: user.profile.first_name, last_name: user.profile.last_name, email: user.email, password: user.password }

      expect(assigns(:user)).to be_a(User)

    end

    context 'when the information is valid' do

      before do

        creating_user

      end

      it 'persists the user to the database' do

        expect(assigns(:user).persisted?).to eq(true)

      end

      it 'persists the profile in the database' do

        expect(assigns(:user).profile.persisted?).to eq(true)

      end

      it 'redirects to the root url' do

        expect(response).to redirect_to(root_path)

      end

    end

    context 'when the information is invalid' do

      before do

        invalid_creating_user

      end

      it 'does not persist the user to the database' do

        expect(assigns(:user).persisted?).to eq(false)

      end

      it 'does not persist the profile to the database' do

        expect(assigns(:user).profile).to be_nil

      end

      it 'redirects to the signup page' do

        expect(response).to redirect_to(new_user_path)

      end

    end

  end

  describe '#edit' do

    context 'when the user is logged in and is the correct user' do

      before do

        user.save
        logging_in_user
        get :edit, id: user.id

      end

      it 'sets the user and profile instance variables' do

        expect(assigns(:user)).to be_a(User)
        expect(assigns(:profile)).to be_a(Profile)

      end

      it 'renders the edit template' do

        expect(response).to render_template(:edit)

      end

    end

    context 'when the user is not logged in' do

      before do

        user.save
        get :edit, id: user.id

      end

      it 'does not set the user, profile, city, state, and country instance variables' do

        expect(assigns(:user)).to be_nil
        expect(assigns(:profile)).to be_nil
        expect(assigns(:cities)).to be_nil
        expect(assigns(:states)).to be_nil
        expect(assigns(:countries)).to be_nil

      end

      it 'tells the user to log in' do

        expect(flash[:notice]).to eq "You must first log in."

      end

      it 'redirects the user to the login page' do

        expect(response).to redirect_to(login_path)

      end

    end

    context 'when the user is not the correct user' do

      before do

        user.save
        new_user = create(:user)
        session[:user_id] = new_user.id
        controller.stub(:current_user) { new_user }
        get :edit, id: user.id

      end

      it 'does not set the user, profile, city, state, and country instance variables' do

        expect(assigns(:user)).to be_nil
        expect(assigns(:profile)).to be_nil
        expect(assigns(:cities)).to be_nil
        expect(assigns(:states)).to be_nil
        expect(assigns(:countries)).to be_nil

      end

      it 'tells the user that he is not authorized to access this page' do

        expect(flash[:notice]).to eq("You are not authorized to access that page.")

      end

      it 'redirects the user to the root path' do

        expect(response).to redirect_to(root_path)

      end

    end

  end


end
