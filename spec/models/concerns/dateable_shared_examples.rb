require 'rails_helper'

shared_examples_for 'Dateable' do
  let(:model){described_class}

  describe '#date' do
    it 'returns a formatted date string for the created_at timestamp of the model'
  end
end