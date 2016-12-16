require 'rails_helper'

describe 'users/show.html.erb' do

  context 'when logged in' do

    it 'a sign out link is displayed'

    context 'when the user is on his own timeline' do

      it 'an edit profile button is displayed'

      it 'a textarea for entering a post is displayed'

      it 'a delete link is displayed by each post'

    end

    context 'when the user is visiting another\'s timeline' do

      it 'an edit profile button is not displayed'

      it 'no post textarea is visible'

      it 'no delete link is shown next to each post'

    end

  end

end