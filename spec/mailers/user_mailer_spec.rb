require "rails_helper"

describe UserMailer, type: :mailer do
  let(:user){ create(:user, :with_profile)}
  let(:mail){ ActionMailer::Base.deliveries}
  let(:friends){ create_list(:user, 3, :with_profile)}
  context 'email basics' do
    before do
      user.email = 'test@gmail.com'
      user.friendees << friends
      UserMailer.welcome(user).deliver
    end
    it 'creates an email' do
      expect(mail.count).to eq(1)
    end
    it 'should have the right recipient' do
      expect(mail.first.to.first).to eq('test@gmail.com')
    end
    it 'should have the correct subject line' do
      expect(mail.first.subject).to eq('Welcome to Danebook!')
    end
    it 'should be sent from the correct address' do
      expect(mail.first.from).to eq(['no-reply@danebook.com'])
    end
    it 'should include friends' do
      expect(mail.first.body.encoded).to match(friends.first.full_name)
    end
    it 'should have a friend\'s avatar' do
      expect(mail.first.body.encoded).to match(friends.first.avatar(:thumb))
    end
  end

end
