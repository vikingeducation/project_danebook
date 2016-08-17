require 'rails_helper'

describe ProfilesController do

  let!(:user) { create(:user) }
  let(:logging_in_user) {

    session[:user_id] = user.id
    controller.stub(:current_user) { user }

  }
  let(:profile) { 

    controller.current_user.profile

  }


  describe "#update" do

    context "when the user is logged in and the profile being edited is correct" do

      before do

        logging_in_user
        post :update, id: profile.id, profile: {

          about: "new about stuff",
          words: "new words stuff",
          college: "Newcollege University"

        }
        profile.reload

      end

      it "assigns the instance variables" do

        expect(assigns(:user)).to be_a(User)
        expect(assigns(:profile)).to be_a(Profile)

      end

      it "changes the attributes of the profile" do

        expect(profile.about).to eq("new about stuff")
        expect(profile.words).to eq("new words stuff")
        expect(profile.college).to eq("Newcollege University")

      end

      it "greets the user with a success message" do

        expect(flash[:success]).to eq("Profile updated.")

      end

      it "redirects the user to the show page" do

        expect(response).to redirect_to(profile.user)

      end

    end

    context "when the user is not logged in" do

      before do

        controller.stub(:current_user) { user }
        post :update, id: profile.id, profile: {

          about: "new about stuff",
          words: "new words stuff",
          college: "Newcollege University"

        }

      end

      it "doesn't assign the instance variables" do

        expect(assigns(:user)).to be_nil
        expect(assigns(:profile)).to be_nil

      end

      it "does not change the attributes of the profile" do

        expect(profile.about).to eq("about myself")
        expect(profile.words).to eq("a few words")
        expect(profile.college).to eq("A College")

      end

      it "warns the user with a notice" do

        expect(flash[:notice]).to eq("You must first log in.")

      end

      it "redirects the user to the login page" do

        expect(response).to redirect_to(login_path)

      end

    end

    context "when the profile being edited is not the correct profile" do

      before do

        logging_in_user
        new_profile = create(:profile)
        post :update, id: new_profile.id, profile: {

          about: "new about stuff",
          words: "new words stuff",
          college: "Newcollege University"

        }

      end

      it 'does not set the user and profile instance variables' do

        expect(assigns(:user)).to be_nil
        expect(assigns(:profile)).to be_nil

      end

      it 'warns the user with a notice' do

        expect(flash[:notice]).to eq("You cannot edit this profile.")

      end

      it 'redirects the user to the root path' do

        expect(response).to redirect_to(root_path)

      end

    end

  end

end