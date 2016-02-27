require "rails_helper"

RSpec.describe UserMailer, type: :mailer do

  describe 'welcome email' do
    let(:user) { create(:user) }
    let(:mail) { UserMailer.welcome(user) }

    it 'renders the subject' do
      expect(mail.subject).to eql('Welcome to Danebook!')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['admin@danebook.com'])
    end

    it 'displays user first name in email body' do
      expect(mail.body.encoded).to match(user.first_name)
    end

    it "displays the link to see user's profile" do
      expect(mail.body.encoded).to match(user_url(user))
    end
  end
end
