require 'rails_helper'

######################################################
# Can I not test these because they're private methods?
# -- can open by testing them directly
######################################################

=begin
describe ApplicationController do

  let(:user) { create(:user) }

  describe '#permanent_sign_in' do

    #before do
    #  sign_in(user)
    #end


    xit 'sets cookies[:auth_token]' do
      expect(cookies[:auth_token]).to eq(user.auth_token)
    end

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
=end