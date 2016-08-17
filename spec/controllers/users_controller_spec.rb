require 'rails_helper'

describe UsersController do
  let!(:user) { create(:user) }
  let!(:profile) { user.profile }

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

    it 'assigns the user instance variable'

    context 'when the information is valid' do

      it 'persists the user to the database'

      it 'persists the profile in the database'

      it 'sends an activation email'

      it 'informs the user about the activation email'

      it 'redirects to the root url'

    end

    context 'when the information is invalid' do

      it 'does not persist the user to the database'

      it 'does not persist the user to the database'

      it 'sends an activation email'

      it 'warns the user about the invalid information'

      it 'redirects to the signup page'

    end

  end

  describe '#edit' do

    context 'when the user is logged in and is the correct user' do

      it 'sets the user, profile, city, state, and country instance variables'

      it 'renders the edit template'

    end

    context 'when the user is not logged in' do

      it 'does not set the user, profile, city, state, and country instance variables'

      it 'tells the user to log in'

      it 'redirects the user to the login page'

    end

    context 'when the user is not the correct user' do

      it 'does not set the user, profile, city, state, and country instance variables'

      it 'tells the user that he is not authorized to access this page'

      it 'redirects the user to the root path'

    end

  end

  describe '#update' do

    context 'when the user is logged in and is the correct user' do

      context 'when the information is valid' do

        it 'sets the user and profile instance variables'

        it 'updates the user\'s attributes'

        it 'tells the user that the update was successful'

        it 'redirects the user to the show page'

      end

      context 'when the information is not valid' do

        it 'does not set the user and profile instance variables'

        it 'does not update the user\'s attributes'

        it 'tells the user that the update was unsuccessful'

        it 'redirects the user to the show page'

      end

    end

    context 'when the user is not logged in' do

      it 'does not set the user, profile, city, state, and country instance variables'

      it 'tells the user to log in'

      it 'redirects the user to the login page'

    end

    context 'when the user is not the correct user' do

      it 'does not set the user, profile, city, state, and country instance variables'

      it 'tells the user that he is not authorized to access this page'

      it 'redirects the user to the root path'

    end

  end


end