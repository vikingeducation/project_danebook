require 'rails_helper'


describe 'photos/index.html.erb' do


  context "when on current user's page" do

    let(:user) { create(:user) }

    before do
      assign(:user, user)
      assign(:photos, Array.new(2) { create(:photo, :poster => user) } )

      def view.current_user
        @user
      end

    end


    it "shows Add Photo button" do
      render
      expect(rendered).to have_link('Add Photo')
    end

  end


  context "when on another user's page" do

    let(:user) { create(:user) }

    before do
      assign(:user, user)
      assign(:photos, Array.new(2) { create(:photo, :poster => user) } )

      def view.current_user
        nil
      end

    end


    it "does not show Add Photo button" do
      render
      expect(rendered).not_to have_link('Add Photo')
    end

  end


end