require 'rails_helper'

describe Photo do

  describe 'Owner association' do

    it { should belong_to(:owner) }

  end


end
