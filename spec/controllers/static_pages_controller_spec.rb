require 'rails_helper'

describe StaticPagesController do
  let(:user){ create(:user) }

  before :each do
    request.cookies['auth_token'] = user.auth_token
  end
  
end
