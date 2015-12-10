require 'rails_helper'

describe PhotosController do
  describe 'GET #index' do
    context 'the user is signed in' do
      it 'sets an instance variable to the user'
      it 'sets an instance variable to the user photos'
      it 'renders the index view'
    end

    context 'the user is signed out' do
      it 'redirects to signup'
      it 'sets an error flash'
    end
  end

  describe 'GET #show' do
    context 'the user is signed in' do
      context 'the user is friends with or is the photos user' do
        it 'renders the show view'
        it 'sets an instance variable to the photo'
      end

      context 'the user is not friends with nor is the photos user' do
        it 'redirects to the photo user profile'
        it 'sets an error flash'
      end
    end

    context 'the user is signed out' do
      it 'redirects to signup'
      it 'sets an error flash'
    end
  end

  describe 'POST #create' do
    context 'the user is signed in' do
      context 'the user is the user attempting to create the photo' do
        it 'creates the photo'
        it 'sets a success flash'
      end

      context 'the user is not the user attempting to create the photo' do
        it 'does not create the photo'
        it 'redirects to new user photo path'
        it 'sets an error flash'
      end
    end

    context 'the user is signed out' do
      it 'redirects to signup'
      it 'sets an error flash'
    end
  end

  describe 'DELETE #destroy' do
    context 'the user is signed in' do
      context 'the user is the user attempting to destroy the photo' do
        it 'destroys the photo'
        it 'sets a success flash'
      end

      context 'the user is not the user attempting to destroy the photo' do
        it 'does not destroy the photo'
        it 'sets an error flash'
      end
    end

    context 'the user is signed out' do
      it 'redirects to signup'
      it 'sets an error flash'
    end
  end
end




