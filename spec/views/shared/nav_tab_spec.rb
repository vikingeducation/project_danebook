require 'rails_helper'


describe "shared/_nav_tab.html.erb" do

  let(:user) { create(:user) }

  before do
    # default is false
    allow(view).to receive(:current_page?).and_return(false)
    allow(view).to receive(:current_page?).with(user_posts_path(user.id)).and_return(true)
  end


  it "should disable the Timeline link" do
    render  :partial => 'shared/nav_tab',
            :locals => {  :label => "Timeline",
                          :link => user_posts_path(user.id),
                          :user => user,
                          :badge => nil }

    expect(rendered).to have_selector('li.text-center.disabled', text: 'Timeline')
  end


  it "should enable other links besides Timeline" do
      render  :partial => 'shared/nav_tab',
            :locals => {  :label => "About",
                          :link => user_path(user.id),
                          :user => user,
                          :badge => nil }

    expect(rendered).to have_selector('li.text-center', text: 'About')
    expect(rendered).not_to have_selector('li.text-center.disabled', text: 'About')
  end

end