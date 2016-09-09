require 'rails_helper'

describe User do
  let(:userb){ build(:user) }
  let(:userc){create(:user)}
  let( :frequent_author ){ create(:user, :frequent_author) }

  it "requires email, password, first_name, last_name, gender, b_month, b_day, b_year to be valid" do
    expect(userb).to be_valid
  end

  it "has method #full_name which concatenates first and last name" do
    expect(userc.full_name).to eq("#{userc.first_name} #{userc.last_name}")
  end

  it "requires that the password be in(3..24)" do
    userb.password = "fo"
    userb.password_confirmation = "fo"
    expect(userb).to_not be_valid
  end

  it "has many posts" do
    expect(userc).to respond_to(:posts) 
  end

  it "has many comments" do
    expect(userc).to respond_to(:comments)
  end

end


# describe User do
#   let(:user){ build(:user) }
#   let(:secret){create(:secret)}
#
#   it "with a name, email, and password is valid" do
#     expect(user).to be_valid
#   end
#
#   it "without a name is invalid" do
#     user.name = nil
#
#     expect(!user.valid?).to be_truthy
#   end
#   it "without an email is invalid" do
#     user.email = nil
#     expect(user).to_not be_valid
#   end
#
#   it "without a password is invalid" do
#     user.password_digest = nil
#     expect(user).to_not be_valid
#   end
#
#   it "with too short of a name is invalid" do
#     user.name = "fa"
#     expect(user).to_not be_valid
#   end
#
#   it "with too short of a password is invalid" do
#     user = build(:user, password: "foo", password_confirmation: "foo")
#     expect(user).to_not be_valid
#   end
#
#   it "responds to the secrets association" do
#     expect(user).to respond_to(:secrets)
#
#   end
