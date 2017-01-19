require 'rails_helper'

describe Image do

  it { is_expected.to belong_to(:gallery) }
end
