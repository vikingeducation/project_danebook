require 'rails_helper'


describe "posts/_new.html.erb" do

  let(:user) { create(:user) }

  before do
    assign(:user, user)

    def view.current_user
      @user
    end

  end


  it "renders form with errors for invalid post" do
    post = user.posts.build(attributes_for(:post))
    post.errors[:body] = 'Body is too long (maximum is 255 characters)'
    render :partial => 'new', :locals => { :new_post => post }
    expect(rendered).to have_css('.error-message')
  end

end