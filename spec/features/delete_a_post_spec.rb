require 'rails_helper.rb'

feature "Deleting a post" do 
  let(:user) {create(:user)}
  let(:user2) {create(:user, email: "blah@gmail.com")}
  let!(:post) {create(:post, user_id: user.id, content: "I AM A ROGUE POST", from: user2.id )}

  scenario "from a user's profile should delete it from their timeline and database" do
    login(user)
    click_on("Timeline")
    expect(Post.count).to eq(1)
    click_on("Delete Post")
    expect(Post.count).to eq(0)
    expect(page).to_not have_content("Delete Post")
  end

  scenario "from a user not that current user should not change the post count" do 
    login(user2)
    visit "/users/#{user.id}/profiles"
    expect(Post.count).to eq(1)
    click_on("Delete Post")
  end

end