require 'rails_helper'

describe ActivitiesController do
  describe 'GET #index' do
    context 'the user is signed in' do
      it 'sets an instance variable to the activity feed for the user'
    end

    context 'the user is signed out' do
      it 'redirects to the signup path'
    end
  end

  describe 'GET #show' do
    context 'the user is signed in' do
      it 'sets an instance variable to the timeline activity for the user'
    end

    context 'the user is signed out' do
      it 'redirects to the signup path'
      it 'sets an error flash'
    end
  end
end
