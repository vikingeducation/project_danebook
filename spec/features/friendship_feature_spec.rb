require 'rails_helper'

describe Friendship do

  let(:user){create(:user)}
  let(:friendship){create(:friendship)}

  before do
    sign_in
  end

  context 'addition' do

    context 'request' do

      scenario 'can be sent from another profile'

      scenario 'can be sent from friends Friends page'

      context 'of existing friend' do

        scenario 'cannot be sent from another profile'

        scenario 'cannot be sent from friends Friends page'

      end

    end

    context 'acceptance' do

      scenario 'can be completed from own Friends page' do
        visit user_friendships_path(user)
      end

    end

  end

  context 'removal' do

    scenario 'can be completed from own Friends page'

    scenario 'deletes friend from own Friends page'

    scenario 'deletes user from friends Friends page'

  end

end