require 'rails_helper'

shared_examples_for 'Friendable' do
  let(:model){described_class}

  describe '#initiator' do
  end

  describe '#approver' do
  end

  describe 'validates' do
    describe 'user pair' do
      it 'is unique'
    end

    describe 'user ids value' do
      it 'does not change on update'
    end
  end

  describe '#find_by_user' do
    it 'returns all records for the given user'
  end

  describe '#find_by_user_id' do
    it 'returns all records given a user id'
  end

  describe '#find_by_users' do
    it 'returns 1 record for the given user pair'
  end

  describe '#find_by_user_ids' do
    it 'returns 1 record for the given user pair'
  end
end