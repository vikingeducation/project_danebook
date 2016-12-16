require 'rails_helper'

RSpec.describe Like, type: :model do
  it { should belong_to(:likable) }
  it { should belong_to(:initiated_user) }
end