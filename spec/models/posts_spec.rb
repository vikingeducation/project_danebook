require 'rails_helper'
require 'pry'

describe Post do


  let(:post){create(:post)}
  let(:user){create(:user)}

  it { should have_many(:likes) }
  it { should have_many(:comments) }

  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:user) }

  it "responds to comments assosiation" do
    expect(post).to respond_to(:comments)
  end

  it "responds to user assosiation" do
    expect(post).to respond_to(:user)
  end


  it "responds to likes assosiation" do
    expect(post).to respond_to(:likes)
  end

end
