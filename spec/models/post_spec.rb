require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should validate_presence_of(:text) }
  it { should validate_length_of(:text).is_at_most(500) }
  it { should belong_to(:user) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:likes).dependent(:destroy) }
end