require 'rails_helper'

describe Comment do
  AWS.stub!
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

  context 'email sent on creation unless commentable owner is comment author' do
    let(:user) { create(:user) }

    # How do I test that UserMailer.comment_notification(args).deliver!
    # is called?
    # it 'should use the proper mailer method to send mail' do
    #   expect(UserMailer).to receive(:comment_notification)
    #   new_comment = create(:comment)
    # end

    it 'should send email if commentable owner is not comment author' do
      new_commentable = create(:post, author: user)
      other_user = create(:user)
      expect do
         create(:comment, commentable: new_commentable, author: other_user)
      end.to change(Delayed::Job, :count).by(1)
    end

    it 'should not send an email if commentable owner is comment author' do
      new_commentable = create(:post, author: user)
      expect do
         create(:comment, commentable: new_commentable, author: user)
      end.to change(Delayed::Job, :count).by(0)
    end

    it 'should send an email if photo owner is comment author' do
      new_photo = create(:photo, author: user)
      other_user = create(:user)
      expect do
         create(:comment, commentable: new_photo, author: other_user)
      end.to change(Delayed::Job, :count).by(1)
    end

    it 'should not send an email if photo owner is comment author' do
      new_photo = create(:photo, author: user)
      expect do
         create(:comment, commentable: new_photo, author: user)
      end.to change(Delayed::Job, :count).by(0)
    end
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
