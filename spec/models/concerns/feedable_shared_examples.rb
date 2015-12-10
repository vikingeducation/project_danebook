require 'rails_helper'

shared_examples_for 'Feedable' do
  let(:model){described_class}

  describe '#create' do
    it 'results in an activity being created'
    it 'creates an activity that has a feedable equal to this record'
    it 'creates an activity that has a verb of create'
    it 'creates an activity for each specified user'
  end
end

