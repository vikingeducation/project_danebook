require 'rails_helper'

describe Friending do

  context 'when saving multiple Friendings' do

    let(:friending) { build(:friending) }

    it 'saves if the Friending does not yet exist' do
      expect(friending).to be_valid
    end

    it 'does not save if the Friending already exists' do
      friending.save
      duplicate_friending = friending.dup
      expect(duplicate_friending).to be_invalid
    end

  end

  context 'when Friending oneself' do

    #it 'does not save if the user is trying to friend himself'

  end

end