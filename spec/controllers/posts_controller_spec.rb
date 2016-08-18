require 'rails_helper'

describe PostsController do 

  let(:user){ create(:user) }
  let(:post){ create(:post) }

  before do 
    post.author = user
  end

  describe "GET #index" do 
    it "sets the proper instance variables" do 
      expect(assigns(:posts)).to include(post)
    end
  end

end