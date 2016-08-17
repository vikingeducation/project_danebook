require 'rails_helper'

describe Profile do 

  let(:profile){ build(:profile) }

  it {is_expected.to belong_to(:user)}

end






