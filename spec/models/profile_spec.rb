require 'rails_helper'

RSpec.describe Profile, type: :model do
  it { should belong_to(:user) }
  it { should validate_length_of(:college).is_at_most(30) }
  it { should validate_length_of(:hometown).is_at_most(30) }
  it { should validate_length_of(:address).is_at_most(30) }
  it { should validate_length_of(:phone).is_at_most(15) }
  it { should validate_length_of(:status).is_at_most(120) }
  it { should validate_length_of(:about).is_at_most(500) }
end