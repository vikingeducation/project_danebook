require 'rails_helper'

describe Profile do

  describe 'custom birthdate validator' do

    it 'accepts a birthdate of today'

    it 'accepts a birthday of 120 years ago from today'

    it 'rejects a birthdate of tomorrow'

    it 'rejects a birthdate of 120 years + 1 day ago from today'

  end


end