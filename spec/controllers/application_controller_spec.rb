require 'rails_helper'


describe ApplicationController do


  describe '#permanent_sign_in' do

    it 'sets cookies[:auth_token]'

    it 'assigns @current_user'

  end


  describe '#current_user' do

    it 'uses @current_user if it exists'

    it 'uses cookie if @current_user does not exist'

  end


  describe '#sign_out' do

    it 'clears cookie'

    it 'forces @current_user to nil'

  end


end