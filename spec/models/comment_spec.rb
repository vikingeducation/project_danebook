require 'rails_helper'

describe Comment do

  let(:comment) { build(:comment, :on_post) }


  context 'polymorphic parents' do

    it 'has commentable_id and _type columns' do
      should have_db_column(:commentable_id)
      should have_db_column(:commentable_type)
      should have_db_index([:commentable_id, :commentable_type])
    end

    it { should belong_to(:commentable) }

  end


  it 'saves with valid attributes' do
    expect(comment).to be_valid
  end


  context 'when validating body length' do

    it 'saves if body is 3 characters' do
      comment.body = "f"*3
      expect(comment).to be_valid
    end

    it 'does not save if body is 2 characters' do
      comment.body = "f"*2
      expect(comment).to be_invalid
    end

    it 'does not save if body is nil' do
      comment.body = nil
      expect(comment).to be_invalid
    end

    it 'saves if body is 140 characters' do
      comment.body = "f"*140
      expect(comment).to be_valid
    end

    it 'does not save if body is 141 characters' do
      comment.body = "f"*141
      expect(comment).to be_invalid
    end

  end


  context 'when receiving malicious input' do

    #it 'saves any html input as plain text'

    #it 'saves any SQL input as plain text'

  end


  context 'when deleting a Comment' do

    let(:like) { build(:comment_like) }
    it 'should delete dependent Likes with no orphans' do
      like.liked.destroy
      expect{ like.reload }.to raise_exception(ActiveRecord::RecordNotFound)
    end

  end


  describe 'Sending notification email' do

    let(:comment) { create(:comment) }
    let(:mailer) { class_double("UserMailer").as_stubbed_const }
    let(:message) { double("UserMailer", deliver!: true)}

    it 'calls notify(comment) on UserMailer' do

      allow(mailer).to receive(:notify).and_return(message)
      expect(mailer).to receive(:notify).with(comment)
      Comment.send_notification(comment.id)
    end

  end

end