require 'rails_helper'

shared_examples_for 'Searchable' do
  let(:model){described_class}

  describe '#search' do
    it 'searches the specified fields with the query string'
    it 'searches with a specified scope'
  end
end

