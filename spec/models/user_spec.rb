require 'rails_helper'

describe User do


  context 'when saving a user' do

    it 'saves with valid attributes'

    context 'when validating email' do

      it 'does not save if format is aaa@bbb'

      it 'does not save if format is bbb.ccc'

      it 'does not save if format is aaa@bbb.c'

      it 'saves if format is aaa@bbb.cc'

    end

    context 'when using a secure password' do

      it 'saves a hashed password'

      it 'does not store the actual password in the database'

      #it 'translates the hashed password with authenticate'

    end

    context 'when accepting Profile attributes' do

      it 'saves profile with user when attributes are valid'

      it 'does not save profile when attributes are invalid'

    end

  end


  describe 'Friendings association' do

    context 'when relationship does not already exist' do

      it 'saves via the method user.friended_users << '

      it 'saves via the method user.users_friended_by << '

      it 'saves via Friending.create(user_id1, user_id2) method'

    end

    context 'when relationship already exists' do

      it 'does not add a row via the method user.friended_users << '

      it 'does not add a row via the method user.users_friended_by << '

      it 'does not add a row via Friending.create(user_id1, user_id2) method'

    end

  end



  context 'when deleting a user' do

    it 'should delete dependent Profile with no orphans'

    it 'should delete dependent Posts with no orphans'

    it 'should delete dependent Likes with no orphans'

    it 'should delete dependent Friendings with no orphans'

    it 'should nullify dependent Comments'

  end

end