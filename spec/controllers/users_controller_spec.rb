require 'rails_helper'

describe UsersController do

  let(:user) { build(:user) }

  it 'should have #new assign a new user object ' do
    get :new

    expect(assigns(:user)).to be_a_new(User)
  end

  it 'should have #index return a list of user results ' do
    create(:user, first_name: "aa")
    create(:user, first_name: "aab")
    create(:user, first_name: "c")

    get :index, name: "a"

    expect(assigns(:users).count).to eq(2)
  end

  it 'should have #index assign no users if no results ' do
    create(:user, first_name: "aa")
    create(:user, first_name: "aab")
    create(:user, first_name: "c")

    get :index, name: "d"

    expect(assigns(:users).count).to eq(0)
  end

  it 'should have #new assign a user with given params' do
    expect{post :create, user: attributes_for(:user)}.to change(User, :count).by(1)
  end

  it 'should not have #new assign a user with given params if duplicate' do
    attrs = attributes_for(:user)
    post :create, user: attrs
    expect{post :create, user: attrs}.to change(User, :count).by(0)
  end

  context 'showing/editing' do

    # Why not use user in let block? That one is built, trying to avoid
    # writing to test db.
    before :all do
      @new_user = create(:user)
    end

    # WARNING: YOU MUST DO THIS
    # WITHOUT THIS LINE THE CREATED USERS ABOVE DO NOT GET ROLLED BACK!
    after :all do
      User.destroy_all
    end

    it 'should have #show assign a user by a given id' do
      get :show, id: @new_user.id
      expect(assigns(:user)).to eq(@new_user)
    end

    it 'should have #show raise an error if user does not exist' do
      expect{get :show, id: User.last.id + 1}.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'should have #edit assign a user by a given id' do
      # Why not use user in let block? That one is built, trying to avoid
      # writing to test db.
      get :show, id: @new_user.id
      expect(assigns(:user)).to eq(@new_user)
    end

    it 'should have #edit raise an error if user does not exist' do
      expect{get :edit, id: -1}.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'should have #update assign a user by a given id' do
      # You use @new_user.attributes rather than attributes_for(@new_user)
      # because @new_user is actually an instance of User ?
      post :update, id: @new_user.id, user: @new_user.attributes
      expect(assigns(:user)).to eq(@new_user)
    end

    it 'should actually update the user' do
      new_first_name = "NEWBIE"
      @new_user.first_name = new_first_name
      post :update, id: @new_user.id, user: @new_user.attributes
      expect(User.first.first_name).to eq(new_first_name)
    end

    it 'should not update the first name if invalid' do
      # @new_user still thinks its old name is the factory preset.
      @new_user.reload
      old_first_name = @new_user.first_name
      @new_user.first_name = ""
      post :update, id: @new_user.id, user: @new_user.attributes
      expect(User.first.first_name).to eq(old_first_name)
    end
  end
end
