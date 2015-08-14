require 'rails_helper'


describe PostsController do

  describe 'GET #index' do

    it 'assigns @user to User being viewed (not current user)'

    it "gathers all of user's posts into @posts"

    it 'assigns @new_post with current_user id if signed in'

    it '@friends size is equal to 6 if total friends >= 6'

    it '@friends size is equal to total friend count if total < 6'

  end


  describe 'POST #create' do

    it 'rejects when author_id in params is not current_user'

  end

end