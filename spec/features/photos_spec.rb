require 'rails_helper'

feature 'Upload Photos' do

  let(:user){ create(:user) }
  # let(:user2){ create(:user) }
  let(:profile){create(:profile)}
  
  before do
    sign_in(user)
  end

  it 'should bring a user to index of photos'

  it 'should have an add photo button if current user'

  it 'should bring user to new photo html when click on'

  it 'should let the current user upload an avatar photo'

  it 'shoud let the current user upload a cover photo'

  it 'should let a current user upload normal photos'

end

