require 'rails_helper.rb'

feature "Liking a post" do 
  let(:user) {create(:user)}
  let(:user2) {create(:user, email: "blah@gmail.com")}
  let!(:post) {create(:post, user_id: user.id, content: "I AM A ROGUE POST", from: user2.id )}

  scenario "a user can like their own post" do
    login(user)
    click_on("Timeline")
    expect(Like.count).to eq(0)
    click_on("Like")
    expect(Like.count).to eq(1)
  end

  scenario "a user can like another person's post" do 
    login(user2)
    visit "/users/#{user.id}"
    expect(Like.count).to eq(0)
    click_on("Like")
    expect(Like.count).to eq(1)
  end

  scenario "a user cannot like a post they have already liked" do 
    login(user)
    click_on("Timeline")
    expect(Like.count).to eq(0)
    click_on("Like")
    expect(Like.count).to eq(1)
    click_on("Like")
    expect(Like.count).to eq(1)
    expect(page).to have_content("You already liked the comment
")
    expect(page).to have_content("1")
  end
end