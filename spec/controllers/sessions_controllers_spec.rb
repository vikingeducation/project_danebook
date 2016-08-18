require 'rails_helper'

describe SessionsController do

  let(:user){create(:user)}

  describe "POST #create" do

    describe "valid log in" do

      it "valid credentials create a new log in" do
        expect{ post :create, email: "foobar@foo.com", password: "foobar" }.to change(Session, :count).by(1)
      end

    end

  end

end