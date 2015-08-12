require 'rails_helper'

describe Comment do

  let(:comment) { create(:comment) }
  describe '#posted_on' do
    it 'should respond to posted on method' do
      expect(comment).to respond_to(:posted_on)
    end

    # This test fails based on local time
    # it 'should have a human readable commented on date' do
    #   expect(comment.posted_on).to eq("Posted on #{DateTime.now.strftime("%A %m/%d/%Y")}")
    # end
  end

  context 'people who like association' do
    it 'should respond to people_who_like association' do
      expect(comment).to respond_to(:people_who_like)
    end

    it 'should get an empty result by default' do
      expect(comment.people_who_like.count).to eq(0)
    end

    it 'should return results once it has likes' do
      comment.likes << create(:liked_comment)
      expect(comment.people_who_like.count).to eq(1)
    end
  end

  context 'author association' do
    it 'should respond to author association' do
      expect(comment).to respond_to(:author)
    end

    it 'should return an author by defualt' do
      expect(comment.author).to be_a(User)
    end
  end

end
