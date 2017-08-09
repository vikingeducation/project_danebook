require "rails_helper"

RSpec.describe UserMailer, type: :mailer do

  let(:user){create(:user)}
  let(:profile){create(:profile, :user => user)}
  let(:post){create(:post, :user => user)}

  let(:user_two){create(:user)}
  let(:profile_two){create(:profile, :user => user_two)}
  let(:comment){create(:comment, :user => user_two, commentable_type: "Post", commentable_id: post.id)}

  before(:each) do
    profile
    profile_two
    post
    comment
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
    UserMailer.welcome(user).deliver
    UserMailer.new_comment_msg(user, comment)
  end

  after(:each) do
    ActionMailer::Base.deliveries.clear
  end

  # it 'renders the receiver email' do
  #   puts  "#{ActionMailer::Base.deliveries.count}"
  #   expect(ActionMailer::Base.deliveries.last.subject).to eq("You have got new comments today!")
  # end

  it 'should send an email' do
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end

  it 'renders the receiver email' do
    expect(ActionMailer::Base.deliveries.first.to).to eq([user.email])
  end

  it 'should set the subject to the correct subject' do
    expect(ActionMailer::Base.deliveries.first.subject).to eq("Welcome to Danebook!")
  end


  it 'renders the sender email' do
    expect(ActionMailer::Base.deliveries.first.from).to eq(['darbis@gmail.com'])
  end


end
