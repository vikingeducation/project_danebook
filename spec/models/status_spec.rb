require 'rails_helper'

describe Status do
  let(:status){ create(:status, :accepted) }

  context "associations" do
    it "has many friend requests " do
      expect{status.friend_requests}.not_to raise_error
    end
  end

end
