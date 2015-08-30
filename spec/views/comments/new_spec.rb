require 'rails_helper'


describe "comments/_new.html.erb" do

  let(:user) { create(:user) }
  let(:post) { create(:post) }

  before do
    assign(:user, user)

    def view.signed_in_user?
      true
    end

  end


  xit "renders form with errors for invalid comment" do
    comment = post.comments.build(attributes_for(:comment))
    comment.errors[:body] = 'Body is too long (maximum is 140 characters)'
    render :partial => 'new', :locals => { :commentable => post }
    expect(rendered).to have_css('.error-message')
  end

end