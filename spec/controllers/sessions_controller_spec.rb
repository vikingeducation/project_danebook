require 'rails_helper'


describe SessionsController do


  describe 'POST #create' do


    context 'when given valid login' do

      it 'assigns @user properly'

      it 'flashes success message'

    end


    context 'when given invalid login' do

      it 'does not assign @user'

      it 'flashes failure message'

    end


  end


end