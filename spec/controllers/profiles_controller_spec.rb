require 'rails_helper'

describe ProfilesController do


  context "edit" do 
    let(:user){create(:user)}
    let(:profile){user.profile}
    before do

      controller_sign_in(user)

    end 

    it "should allow you to edit your own page" do
      get :edit, id: profile.id
      expect(response).to render_template :edit
    end

    it "should redirect you if you are not an authorized user" do
      new_user = create(:user)
      get :edit, id: new_user.profile.id

      #current user = user as defined in controller_sign_in method
      expect(response).to redirect_to(edit_profile_path(user.profile.id)) 
    end


    context 'update' do
      let(:user){create(:user)}
      let(:profile){user.profile}
      before do
        controller_sign_in(user)
      end
      it "should update attributes" do
        put :update, id: profile.id, 
            profile: attributes_for(:user, college: 'hogwarts')
        profile.reload
        expect(user.profile.college).to eql('hogwarts')
      end

      it "should not update other users attributes" do
        controller_sign_in(create(:user))
        put :update, id: profile.id,
            profile: attributes_for(:user, college: 'hogwarts')
        profile.reload
        expect(user.profile.college).not_to eql('hogwarts')
      end

      # it "should render edit page on failed update" do  
      #   allow(@profile).to receive(:update).and_return(false)
      #   put :update, id: profile.id,
      #                profile: attributes_for(:profile, college: 'hogwarts')

      #   expect(response).to render_template :edit
      # end
    end

    context 'timeline' do
      let(:user){create(:user)}
      let(:profile){user.profile}

      before {get :timeline, profile_id: profile.id}
      it "should render timeline" do
        expect(response).to render_template "timeline"
      end
    end


    context 'show' do
      let(:user){create(:user)}
      let(:profile){user.profile}

      it "should show the about profile page" do
        get :show, id: profile.id
        expect(response).to render_template :about
      end
    end

  end


  end