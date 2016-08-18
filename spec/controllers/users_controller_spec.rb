require 'rails_helper'

describe UsersController do
  let(:profile){ build(:profile) }
  let(:user){ build(:user, profile: profile) }

  context 'signed in user' do
    before do
      user.save!
      login(user)
    end

    describe 'POST #new' do
      before { post :new, user: user }
      it "redirects to current user" do
        expect(response).to redirect_to user
      end
    end

    describe 'GET #show' do
      let(:posts) { create_list(:post, 5) }
      before do
        user.posts << posts
        get :show, id: user
      end
      it "should render show page" do
        expect(response).to render_template :show
      end
      it "should set variables properly" do
        expect(assigns(:user)).to eq(user)
        expect(assigns(:posts)).to match_array(posts)
      end
    end
  end


  context 'user not signed in' do
    describe 'GET #new' do
      before { get :new, user: user }
      context 'with valid information' do
        it 'renders new page' do
          expect(response).to render_template :new
        end
      end
    end

    describe 'POST #create' do
      context 'creating a user with valid information' do
        it "increases user count" do
          expect { post :create, user: attributes_for(:user) }.to change(User, :count).by(1)
        end

        context "creating a new user" do
          before { post :create, user: attributes_for(:user) }
          it { should set_flash[:success] }
          it 'redirects to user page' do
            expect(response).to redirect_to user_path(assigns(:user))
          end
        end
      end

      context 'creating a user with invalid information' do
        it "doesn't change user count" do
          expect { post :create, user: attributes_for(:user, email: "") }.to change(User, :count).by(0)
        end
        context "creating a user with invalid attributes" do
          before { post :create, user: attributes_for(:user, email: "") }
          it { should set_flash[:error] }
          it 'redirects to root' do
            expect(response). to redirect_to root_path
          end
        end
      end
    end

    describe 'GET #show' do
      before do
        user.save!
        get :show, id: user
      end
      it "should redirect to root" do
        expect(response).to redirect_to root_path
      end
    end
  end
end



# describe 'GET #index' do
#   before { get :index, users: users}
#   it 'collects users into @users' do
#     expect(assigns(:users)).to match_array(users)
#   end
# end
