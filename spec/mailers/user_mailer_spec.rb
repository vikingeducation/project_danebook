require "rails_helper"

RSpec.describe UserMailer, type: :mailer do

  let(:user){create(:user)}
  let(:profile){create(:profile, :user => user)}


  before(:each) do
    profile
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
    UserMailer.welcome(user).deliver
  end

  after(:each) do
    ActionMailer::Base.deliveries.clear
  end


  it 'should send an email' do
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end

  it 'renders the receiver email' do
    puts "#{user.email} - his email"
    puts "#{ActionMailer::Base.deliveries.first}"
    expect(ActionMailer::Base.deliveries.first.to).to eq([user.email])
  end

  it 'should set the subject to the correct subject' do
    expect(ActionMailer::Base.deliveries.first.subject).to eq("Welcome to Danebook!")
  end


  it 'renders the sender email' do
    expect(ActionMailer::Base.deliveries.first.from).to eq(['darbis@gmail.com'])
  end


end
