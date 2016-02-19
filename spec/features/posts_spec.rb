require 'rails_helper'


feature 'visitors' do

  let(:user) { build(:user) }
  
  scenario "cannot access timeline" do
    user.save
    visit user_timeline_path(user)

    expect(page).to have_content('Error! Not authorized, please sign in!')
  end
end



feature 'existing posts' do

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


feature 'logged in user and posts' do

"logged in user can create a post"
"logged in user can delete a post"
"logged in user cannot delete a post they didn't write"



end