require 'rails_helper'

describe Sessionizer do
  let(:user){build(:user)}
  let(:bad_params){{password: "23456Yuiopasdf"}}
  let(:sess){ Sessionizer.validate_credentials(user, "!23456Yuiopasdf") }
  let(:sess_bad){ Sessionizer.validate_credentials(user, "23456Yuiopasdf") }

  before do
    user
  end

  describe "#validate_credentials" do
    it "logs in a user with valid credentials" do
      expect(sess).to eq("valid")
    end

    it "rejects a user with invalid credentials" do
      expect(sess_bad).to eq("invalid")
    end

    it "locks you out if you have 5 incorrect logins within an hour" do
      5.times do
        Sessionizer.validate_credentials(user, "!23456Yuiopasdfa")
        user.reload
      end

      expect(sess_bad).to eq("locked")
    end

    it "lockout count resets after an hour" do
      3.times do
        Sessionizer.validate_credentials(user, "!23456Yuiopasdfa")
      end
      user.last_attempt = 1.hour.ago
      expect(sess_bad).to eq("invalid")
      expect(user.failed).to eq(1)

      5.times do
        Sessionizer.validate_credentials(user, "!23456Yuiopasdfa")
      end
      user.last_attempt = 1.hour.ago
      expect(sess_bad).to eq("invalid")
    end
  end

end
