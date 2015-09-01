require "rails_helper"

RSpec.describe UserMailer, type: :mailer do


  describe 'welcome' do

    let(:user) { create(:user) }
    let(:mail) { UserMailer.welcome(user) }

    it 'renders the subject' do
      expect(mail.subject).to eq('Welcome to Danebook!')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['no_reply@ajk-danebook.herokuapp.com'])
    end

    it 'assigns @name' do
      expect(mail.body.encoded).to match(user.profile.full_name)
    end

    it 'includes user profile path' do
      expect(mail.body.encoded).to match("http://test.host/users/#{user.id}")
    end

  end


  describe 'notify for comment on post' do

    let(:comment) { create(:comment, :on_post) }
    let(:mail) { UserMailer.notify(comment) }

    it 'renders the subject' do
      expect(mail.subject).to eq("#{comment.author.profile.full_name} commented on your post!")
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([comment.commentable.poster.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['no_reply@ajk-danebook.herokuapp.com'])
    end

    it "includes the notified user's name" do
      expect(mail.body.encoded).to match(comment.commentable.poster.profile.full_name)
    end

    it 'includes user post path' do
      expect(mail.body.encoded).to match("http://test.host/users/#{comment.commentable.poster.id}/posts")
    end

  end


  describe 'notify for comment on photo' do

    let(:comment) { create(:comment, :on_photo) }
    let(:mail) { UserMailer.notify(comment) }

    it 'renders the subject' do
      expect(mail.subject).to eq("#{comment.author.profile.full_name} commented on your photo!")
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([comment.commentable.poster.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['no_reply@ajk-danebook.herokuapp.com'])
    end

    it "includes the notified user's name" do
      expect(mail.body.encoded).to match(comment.commentable.poster.profile.full_name)
    end

    it 'includes user post path' do
      expect(mail.body.encoded).to match("http://test.host/users/#{comment.commentable.poster.id}/photos/#{comment.commentable.id}")
    end

  end


end
