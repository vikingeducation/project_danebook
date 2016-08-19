require 'rails_helper'

describe Comment do

  let(:comment) { build(:comment) }
  subject { comment }

  it { is_expected.to have_many(:likes)}

end
