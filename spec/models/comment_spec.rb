require 'rails_helper'

describe Comment do

  it 'saves with valid attributes'

  context 'when validating body length' do

    it 'saves if body is 3 characters'

    it 'does not save if body is 2 characters'

    #it 'does not save if body is nil'

    it 'saves if body is 140 characters'

    it 'does not save if body is 141 characters'

  end


  context 'when receiving malicious input' do

    #it 'saves any html input as plain text'

    #it 'saves any SQL input as plain text'

  end


  context 'when deleting a Comment' do

    it 'should delete dependent Likes with no orphans'

  end

end