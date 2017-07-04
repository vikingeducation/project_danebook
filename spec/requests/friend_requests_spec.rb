require "rails_helper"

describe "FriendRequest" do
  let(:pending_status){create(:status, :pending)}
  let(:accepted_status){create(:status, :accepted)}
  let(:user) do
    create(:profile).user
  end
  let(:pending_friend_request) do
    create(:friend_request,
           user_one_id: user.id,
           user_two_id: create(:user).id,
           status_id: pending_status.id)
  end
  before do
    ## persist
    [pending_status, accepted_status]
  end

  describe "GET #index" do
    it "returns a successfull response if the user_id exists" do
      get friend_requests_path(user_id: user.id)
      expect(response.code.to_i).to be 200
    end

    it "raises an error if the user_id does not exist" do
      ## dont know how to correct the error
      expect{
        get friend_requests_path(user_id: user.id + 1)
      }.to raise_error(ActionView::Template::Error)
    end
  end

  describe "POST #create" do
    it "creates a new friend request if valid" do
      # login
      post session_path, params: {email: user.email, password: user.password}
      expect{
        post friend_requests_path, params: {user_id: create(:user).id}
      }.to change(FriendRequest, :count).by(1)
    end

    it "makes no action if there is no logged in user" do
      expect{
        post friend_requests_path, params: {user_id: create(:user).id}
      }.to change(FriendRequest, :count).by(0)
    end

    it "redirects back" do
      # login
      post session_path, params: {email: user.email, password: user.password}
      post friend_requests_path, params: {user_id: create(:user).id}
      expect(response.code.to_i).to be 302
    end
  end

  describe "PUT #update" do
    context "logged in user" do
      before do
        ## login
        post session_path, params: {email: user.email, password: user.password}
      end

      it "updates the friend request to accepted if valid" do
        put friend_request_path(pending_friend_request.id)
        pending_friend_request.reload
        expect(flash[:success]).not_to be nil
        expect(pending_friend_request.status.id).to be accepted_status.id
      end

      it "redirects back" do
        put friend_request_path(pending_friend_request.id)
        expect(response.code.to_i).to be 302
      end
    end

    context "not logged in user" do
      it "doesn't do anything" do
        put friend_request_path(pending_friend_request.id)
        pending_friend_request.reload
        ## status not changed
        expect(pending_friend_request.status.id).to be pending_status.id
        ## redirected to root
        expect(response.code.to_i).to be 302
      end
    end
  end

  describe "DELETE #destroy" do
    context "logged in user" do
      before do
        ## login
        post session_path, params: {email: user.email, password: user.password}
        ## persist
        pending_friend_request
      end

      it "deletes the friend request" do
        ## database
        expect{
          delete friend_request_path(pending_friend_request.id)
        }.to change(FriendRequest, :count).by(-1)
        ## flash
        expect(flash[:success]).not_to be nil
        ## redirect
        expect(response.code.to_i).to be 302
      end
    end

    context "not logged in user" do
      ## persist
      before { pending_friend_request }

      it "doesn't do anything" do
        ## database
        expect{
          delete friend_request_path(pending_friend_request.id)
        }.to change(FriendRequest, :count).by(0)
        ## flash not touched
        expect(flash[:success]).to be nil
        expect(flash[:danger]).to be nil
        ## redirected
        expect(response.code.to_i).to be 302
      end
    end
  end
end
