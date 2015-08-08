require 'rails_helper'

describe UsersController do

  let(:user) { build(:user) }

  it 'should have #new assign a new user object ' do
    get :new

    expect(assigns(:user)).to be_a_new(User)
  end

  it 'should have #index return a list of user results ' do
    user_1 = create(:user, first_name: "aa")
    user_2 = create(:user, first_name: "aab")
    user_3 = create(:user, first_name: "c")

    get :index, name: "a"

    expect(assigns(:users).count).to eq(2)
  end

  it 'should have #index assign no users if no results ' do
    user_1 = create(:user, first_name: "aa")
    user_2 = create(:user, first_name: "aab")
    user_3 = create(:user, first_name: "c")

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

    before :all do
      @new_user = create(:user)
    end

    after :all do
      User.destroy_all
    end

    it 'should have #show assign a user by a given id' do
      # Why not use user in let block? That one is built, trying to avoid
      # writing to test db.
      @new_user = create(:user)
      get :show, id: @new_user.id
      expect(assigns(:user)).to eq(@new_user)
    end

    it 'should have #edit assign a user by a given id' do
      # Why not use user in let block? That one is built, trying to avoid
      # writing to test db.
      @new_user = create(:user)
      get :show, id: @new_user.id
      expect(assigns(:user)).to eq(@new_user)
    end
  end
end
