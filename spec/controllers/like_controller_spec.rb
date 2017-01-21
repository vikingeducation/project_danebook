require 'rails_helper'

describe LikesController do

  context 'post#create' do

    it 'likes a post or comment'

    it 'displays a success flash'

    it 'redirects to the timeline of the user whose post was liked'

    it 'does not like a post or comment if it has already been liked'

  end

  context 'delete#destroy' do

    it 'removes a like'

    it 'displays a flash success'

    it 'redirects to the timeline of the user whose post was liked'

  end

end