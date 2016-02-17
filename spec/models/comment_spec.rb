require 'rails_helper'


describe Comment do

  let(:comment) { build(:comment) }

  let(:overshare) { "Chartreuse deep v tofu you probably haven't heard of them, yuccie normcore cardigan poutine humblebrag yr salvia leggings photo booth squid authentic. Hammock irony +1 stumptown, yr pinterest PBR&B mlkshk shabby chic migas pop-up intelligentsia before they sold out." }



  it "can't create a comment without a body" do
    expect { create(:comment, body: nil) }.to raise_error(ActiveRecord::RecordInvalid)
  end


  it  "can't create a comment with a super-long body" do
    expect { create(:comment, body: overshare) }.to raise_error(ActiveRecord::RecordInvalid)
  end


  it "likes are deleted when a comment is deleted" do
    comment.save
    create(:comment_like, likeable_id: comment.id)
    num_likes = comment.likes.count
    expect(num_likes).to eq(1)

    comment.destroy
    expect(comment.likes.count).to eq(0)
  end


end