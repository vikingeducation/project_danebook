require 'rails_helper'

describe 'posts/index.html.erb' do
  let(:male){create(:male)}
  let(:user){create(:user, :gender => male)}
  let(:posts){create_list(:post, 10, :user => user)}
  let(:users){create_list(:user, 5)}
  
end