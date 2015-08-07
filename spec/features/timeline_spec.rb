require 'rails_helper'

feature "Timeline" do 
let(:user){create(:user)}

  before do
    sign_in(user)
  end


context "posts" do
  scenario 'Should be able to write posts on your own timeline' do
     fill_in 'post_body', with: "Test Post"
     click_button "Post"
     expect(page).to have_content "Test Post"
  end

end

  
end