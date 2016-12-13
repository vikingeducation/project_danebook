require 'rails_helper'

describe Sessionizer do
  let(:user){build(:user)}
  let(:params){{password: "!23456Yuiopasdf"}}
  let(:bad_params){{password: "23456Yuiopasdf"}}
  let(:sess){ Sessionizer.new(user, params) }
  let(:sess_bad){ Sessionizer.new(user, bad_params) }

  before do
    user.save
  end

  describe "#validate_credentials" do
    it "logs in a user with valid credentials" do
      expect(sess.validate_credentials).to eq("valid")
    end

    it "rejects a user with invalid credentials" do
      expect(sess_bad.validate_credentials).to eq("invalid")
    end

    it "locks you out if you have 5 incorrect logins within an hour" do
      5.times do
        sess_bad.validate_credentials
      end
      expect(sess_bad.validate_credentials).to eq("locked")
    end

    it "lockout count resets after an hour" do
      3.times do
        sess_bad.validate_credentials
      end
      user.last_attempt = 1.hour.ago
      expect(sess_bad.validate_credentials).to eq("invalid")
      expect(user.failed).to eq(1)

      5.times do
        sess_bad.validate_credentials
      end
      user.last_attempt = 1.hour.ago
      expect(sess_bad.validate_credentials).to eq("invalid")
    end
  end

end
