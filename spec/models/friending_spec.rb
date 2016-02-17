require 'rails_helper'

describe Friending do

  let(:friending) { build(:friending) }
  

  it "can't create the exact same friendship" do
    create(:friending)
    expect { create(:friending) }.to raise_error(ActiveRecord::RecordInvalid)
  end


  xit "can't have the same friend_id and friender_id" do
    expect { create(:friending, friend_id: 1, friender_id: 1)}.to raise_error(ActiveRecord::RecordInvalid)
  end

end