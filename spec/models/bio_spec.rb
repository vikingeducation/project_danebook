require 'rails_helper'

describe Bio do
  it { is_expected.to belong_to(:profile) }
end
