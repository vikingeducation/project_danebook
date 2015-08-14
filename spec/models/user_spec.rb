require 'rails_helper'

describe User do

  let(:user) { create(:user) }


  context 'when saving a user' do

    it 'saves with valid attributes' do
      expect(user).to be_valid
    end


    context 'when validating email' do

      it 'does not save if format is aaa@bbb' do
        user.email = "aaa@bbb"
        expect(user).to be_invalid
      end

      it 'does not save if format is bbb.ccc' do
        user.email = "bbb.ccc"
        expect(user).to be_invalid
      end

      it 'does not save if format is aaa@bbb.c' do
        user.email = "aaa@bbb.c"
        expect(user).to be_invalid
      end

      it 'saves if format is aaa@bbb.cc' do
        user.email = "aaa@bbb.cc"
        expect(user).to be_valid
      end

    end


    context 'when using a secure password' do

      it 'saves a hashed password' do
        expect(user.password_digest).to be_truthy
      end

      it 'does not store the actual password in the database' do
        expect(user.password_digest).not_to match(/foobar/)
      end

      it 'translates the hashed password with authenticate' do
        expect(user.authenticate('foobar')).to eq(user)
      end

    end


    context 'when accepting Profile attributes' do

      let(:user_with_profile) { create(:user, :profile_attributes => attributes_for(:base_profile)) }

      it 'saves profile with user when attributes are valid' do
        expect(user_with_profile).to be_persisted
        expect(user_with_profile.profile).to be_persisted

        check_profile = build(:base_profile)
        expect(user_with_profile.profile.first_name).to eq(check_profile.first_name)
        expect(user_with_profile.profile.gender).to eq(check_profile.gender)
      end

      it 'does not save profile when attributes are invalid' do
        invalid_attributes = attributes_for(:base_profile, :first_name => nil)
        expect{ create(:user, :profile_attributes => invalid_attributes) }.to raise_exception(ActiveRecord::RecordInvalid)
      end

    end

  end




  describe 'Friendings association' do

    let(:other_user) { create(:user) }

    context 'when relationship does not already exist' do

      it 'saves via the method user.friended_users << ' do
        user.friended_users << other_user
        expect(user.initiated_friendings.where(friend_id: other_user.id).count).to eq(1)
      end

      it 'saves via the method user.users_friended_by << ' do
        user.users_friended_by << other_user
        expect(user.received_friendings.where(friender_id: other_user.id).count).to eq(1)
      end

      it 'saves via Friending.create(user_id1, user_id2) method' do
        Friending.create(friender_id: user.id, friend_id: other_user.id)
        expect(user.friended_users.count).to eq(1)

        Friending.create(friender_id: other_user.id, friend_id: user.id)
        expect(user.users_friended_by.count).to eq(1)
      end

    end

    context 'when relationship already exists' do

      let(:already_friended_user) { create(:user) }
      let(:already_friended_by_user) { create(:user) }

      before do
        user.friended_users << already_friended_user
        user.users_friended_by << already_friended_by_user
      end

      it 'fails to add a row via the method user.friended_users << ' do
        expect{ user.friended_users << already_friended_user }.to raise_exception(ActiveRecord::RecordInvalid)
      end

      it 'fails to add a row via the method user.users_friended_by << ' do
        expect{ user.users_friended_by << already_friended_by_user }.to raise_exception(ActiveRecord::RecordInvalid)
      end

      it 'fails to add a row via Friending.create(user_id1, user_id2) method' do
        expect{ Friending.create(friender_id: user.id, friend_id: already_friended_user.id) }.not_to change(user.friended_users, :count)
        expect{ Friending.create(friender_id: already_friended_by_user.id, friend_id: user.id) }.not_to change(user.users_friended_by, :count)
      end

    end

  end



  context 'when deleting a user' do

    let(:profile) { build(:base_profile) }
    let(:post) { build(:post) }
    let(:comment) { build(:comment) }
    let(:like) { build(:post_like) }
    let(:initiated_friending) { build(:friending) }
    let(:received_friending) { build(:friending) }

    before do
      profile.user = user
      user.posts << post
      user.comments << comment
      user.likes << like
      user.initiated_friendings << initiated_friending
      user.received_friendings << received_friending
      user.destroy
    end

    it 'should delete dependent Profile with no orphans' do
      expect_destroyed_orphan(profile)
    end

    it 'should delete dependent Posts with no orphans' do
      expect_destroyed_orphan(post)
    end

    it 'should nullify dependent Comments' do
      expect_destroyed_orphan(comment)
    end

    it 'should delete dependent Likes by that user with no orphans' do
      expect_destroyed_orphan(like)
    end

    it 'should delete dependent initiatied Friendings with no orphans' do
      expect_destroyed_orphan(initiated_friending)
    end

    it 'should delete dependent received Friendings with no orphans' do
      expect_destroyed_orphan(received_friending)
    end

  end

end