require 'rails_helper'


feature 'visitors' do

  let(:user) { build(:user) }
  
  scenario "cannot access timeline" do
    user.save
    visit user_timeline_path(user)

    expect(page).to have_content('Error! Not authorized, please sign in!')
  end
end



feature 'order of existing posts' do

  let(:user) { build(:user) }

  before do
    user.save
    log_in(user)

    Timecop.freeze(Time.local(2015,2,14))
    create(:post, user_id: user.id)
    Timecop.freeze(Time.local(2015))
    create(:post, user_id: user.id)
    Timecop.freeze(Time.local(2014, 9, 1))
    create(:post, user_id: user.id)
    Timecop.freeze(Time.local(2013,11,7,5))
    create(:post, user_id: user.id)

    visit user_timeline_path(user)
  end


  scenario "are sorted in descending chronological order" do
    first = find(".posts li:nth-child(1)").text
    second = find(".posts li:nth-child(2)").text
    third = find(".posts li:nth-child(3)").text
    fourth = find(".posts li:nth-child(4)").text

    expect(first).to include("Saturday 02/14/15")
    expect(second).to include("Thursday 01/01/15")
    expect(third).to include("Monday 09/01/14")
    expect(fourth).to include("Thursday 11/07/13")
  end

end


feature 'logged in user' do

  let(:user) { build(:user) }
  let(:post ) { build(:post, user_id: user.id) }

  before do
    user.save
    log_in(user)
  end

  scenario "can create a post" do
    visit user_timeline_path(user)

    post_body = "This is my post body"
    find('#post_body').set(post_body)
    click_on("Post")

    expect(page).to have_content("Success! Post created")
    expect(page).to have_content(post_body)
  end


  scenario "with a post can create another post" do
    post.save
    visit user_timeline_path(user)

    post_body = "This is my second post"
    find('#post_body').set(post_body)
    click_on("Post")

    expect(page).to have_content("Success! Post created")
    expect(page).to have_content(post_body)
  end


  scenario "can delete their own post" do
    post.save
    visit user_timeline_path(user)    

    click_on("Delete")
    expect(page).to have_content("Success! Post deleted")
    expect(page).to_not have_content(post.body)
  end


  scenario "logged in user cannot delete another user's post" do
    user2 = create(:user)
    create(:post, user_id: user2.id)
    post.save
    visit user_timeline_path(user2)

    expect(page).to_not have_link("Delete", user_post_path(user2.id, post.id))
  end



end