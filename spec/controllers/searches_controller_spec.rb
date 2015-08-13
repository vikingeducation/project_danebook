require 'rails_helper'

RSpec.describe SearchesController, type: :controller do

  context 'logged in user' do
    before :each do
      cookies[:auth_token] = user.auth_token
    end

    it 'returns a list of users that matches query'

  end

end
