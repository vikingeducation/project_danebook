require 'rails_helper'

describe PostsController do

  context 'post#create' do

    it 'allows users to create posts on their own timeline'

    it 'does not allow users to create posts on another user\'s timeline'

  end

  context 'get#index' do

    it 'allows users to view posts on any timeline'

  end

  context 'delete#destroy' do

    it 'allows users to delete their own posts'

    it 'does not allow users to delete others\' posts'

  end

end