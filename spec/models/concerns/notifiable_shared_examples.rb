require 'rails_helper'

shared_examples_for 'Notifiable' do
  let(:model){described_class}

  describe '#create' do
    it 'results in a notification email being queued'
  end
end

