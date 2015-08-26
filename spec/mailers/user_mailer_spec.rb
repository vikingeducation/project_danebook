require "rails_helper"

RSpec.describe UserMailer, type: :mailer do

  describe 'instructions' do

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

end
