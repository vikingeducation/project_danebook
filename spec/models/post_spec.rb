require 'rails_helper'



describe Post do

  let(:post) { build(:post) }

  let(:overshare) { "Chartreuse deep v tofu you probably haven't heard of them, yuccie normcore cardigan poutine humblebrag yr salvia leggings photo booth squid authentic. Hammock irony +1 stumptown, yr pinterest PBR&B mlkshk shabby chic migas pop-up intelligentsia before they sold out." }



  it "can't create a post without a user_id" do
    expect { create(:post, user_id: nil) }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "can't create a post without a body" do
    expect { create(:post, body: nil) }.to raise_error(ActiveRecord::RecordInvalid)    
  end


  it "can't create a post with a super-long body" do
    expect { create(:post, body: overshare) }.to raise_error(ActiveRecord::RecordInvalid)     
  end


  it "comments are deleted when a post is deleted" do
    post.save
    create(:comment, post_id: post.id)
    num_comments = post.comments.count
    expect(num_comments).to eq(1)

    post.destroy
    expect(post.comments.count).to eq(0)
  end


  it "likes are deleted when a post is deleted" do
    post.save
    create(:post_like, likeable_id: post.id)
    num_likes = post.likes.count
    expect(num_likes).to eq(1)

    post.destroy
    expect(post.likes.count).to eq(0)
  end

end