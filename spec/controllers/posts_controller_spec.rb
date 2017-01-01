require 'rails_helper'

describe PostsController do
  let(:profile) { create(:profile) }
  let(:user) { create(:user, profile: profile) }
  let(:other_user) { create(:user, profile: profile) }
  let(:posty) { create(:post) }

  context 'logged in user' do
    before do
      login(user)
    end

    # context '#create' do
    #   before { post :create, user_id: user, post: attributes_for(:post)}
    #
    #   it 'should redirect to current user' do
    #     expect(response).to redirect_to user
    #   end
    #   it { should set_flash[:success]}
    # end

    # context 'with a pre-existing post' do
    #   before { user.posts << posty }
    #   context '#destroy' do
    #     before { delete :destroy, id: posty }
    #     it 'should redirect to current user' do
    #       expect(response).to redirect_to user
    #     end
    #     it { should set_flash[:success]}
    #   end
    # end
    context 'with another user with a post' do
      before { other_user.posts << posty }
      context '#destroy another users post' do
        it 'should throw an error' do
          expect{ delete :destroy, id: posty }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end

  context 'logged out user' do
    context '#create' do
      before { post :create, user_id: user, post: attributes_for(:post)}
      it 'should redirect to root' do
        expect(response).to redirect_to root_path
      end
      it { should set_flash[:error] }
    end
    context 'with a pre-existing post' do
      before { user.posts << posty }
      context '#destroy' do
        before { delete :destroy, id: posty }
        it 'should redirect to root' do
          expect(response).to redirect_to root_path
        end
        it { should set_flash[:error] }
      end
    end
  end


end
