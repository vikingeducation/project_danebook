require 'rails_helper'

describe Post do

  let(:post) { build(:post) }
  subject { post }

  it { is_expected.to have_many(:likes)}

end
