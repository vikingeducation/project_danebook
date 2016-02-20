require 'rails_helper'


describe UsersController do
  it { should use_before_action(:require_login) }
end



describe PostsController do

  describe "GET#index" do

    let(:user) { create(:user) }
    let(:post) { create(:post, user_id: user.id) }

    before do
      user
      post
      request.cookies[:auth_token] = user.auth_token
      @request.env['HTTP_REFERER'] = root_path
    end


    it  "sets the correct instance variables" do
      get :index, user_id: user.id

      expect(assigns(:posts)).to eq([post])
      expect(assigns(:user)).to eq(user)
      expect(assigns(:new_post)).to be_instance_of(Post)
      expect(assigns(:new_comment)).to be_instance_of(Comment)
    end

  end

end