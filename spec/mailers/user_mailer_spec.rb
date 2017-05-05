require "rails_helper"

describe UserMailer, type: :mailer do
  let(:user){ create(:user, :with_profile)}
  let(:comment){ create(:comment, :for_post, user: user)}
  let(:mail){ ActionMailer::Base.deliveries}
  let(:friends){ create_list(:user, 3, :with_profile)}

  describe 'welcome email' do
    before do
      user.email = 'test@gmail.com'
      user.friendees << friends
      UserMailer.welcome(user).deliver
    end
    it 'creates an email' do
      expect(mail.count).to eq(1)
    end
    it 'should have the right recipient' do
      expect(mail.last.to.first).to eq('test@gmail.com')
    end
    it 'should have the correct subject line' do
      expect(mail.last.subject).to eq('Welcome to Danebook!')
    end
    it 'should be sent from the correct address' do
      expect(mail.last.from).to eq(['no-reply@danebook.com'])
    end
    it 'should include friends' do
      expect(mail.last.body.encoded).to match(friends.first.full_name)
    end
    it 'should have link to friend\'s page' do
      expect(mail.last.body.encoded).to match(user_profile_url(friends.first))
    end
  end
  describe 'comment notification email' do
    before do
      user.email = 'test@gmail.com'
      UserMailer.comment_notification(comment).deliver
    end
    it 'should have the right recipient' do
      expect(mail.last.to.first).to eq(comment.commentable.user.email)
    end
    it 'should have the right subject line' do
      expect(mail.last.subject).to eq("New Comment from #{comment.user.full_name}")
    end
    it 'should be sent from the correct address' do
      expect(mail.last.from).to eq(['no-reply@danebook.com'])
    end
    it 'should contain the comment body' do
      expect(mail.last.body.encoded).to have_text(comment.body)
    end
    it 'should have a link to the commenter\'s profile page' do
      expect(mail.last.body.encoded).to match(user_profile_url(comment.user))
    end
  end

end
