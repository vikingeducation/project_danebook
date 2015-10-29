require 'rails_helper'


describe "likes/_likes_display.html.erb" do

  let(:user) { create(:user) }

  before do

      def view.signed_in_user?
        true
      end

      def view.current_user
        @user
      end

      assign(:user, user)

  end




  context 'when viewing a Post with a lot of likes' do

    let(:liked_post) { create(:post) }

    before do
      liked_post.likers = Array.new(4) { create(:user) }
    end


    it "conjugates verb as 'like'" do
      render :partial => 'likes/likes_display', :locals => { :liked_object => liked_post }
      expect(rendered).to have_content('like')
      expect(rendered).not_to have_content('likes')
    end



    context 'when current user likes it' do

      before do
        liked_post.likers << user
        render :partial => 'likes/likes_display', :locals => { :liked_object => liked_post }
      end

      it "displays 'You'" do
        expect(rendered).to have_content('You')
      end

      it "displays one other user name" do
        expect(rendered).to have_content(liked_post.likers.first.profile.full_name)
        expect(rendered).not_to have_content(liked_post.likers[1].profile.full_name)
      end

    end




    context 'when current user does not like it' do

      before do
        render :partial => 'likes/likes_display', :locals => { :liked_object => liked_post }
      end

      it "displays two user names" do
        expect(rendered).to have_content(liked_post.likers.first.profile.full_name)
        expect(rendered).to have_content(liked_post.likers[1].profile.full_name)
        expect(rendered).not_to have_content(liked_post.likers[2].profile.full_name)
      end

      it "conjugates verb as 'like'" do
        expect(rendered).to have_content('like')
        expect(rendered).not_to have_content('likes')
      end

    end

  end




  context 'when viewing a Comment with a lot of likes' do

    let(:liked_comment) { create(:comment) }

    before do
      liked_comment.likers = Array.new(4) { create(:user) }
    end


    it "conjugates verb as 'like'" do
      render :partial => 'likes/likes_display', :locals => { :liked_object => liked_comment }
      expect(rendered).to have_content('like')
      expect(rendered).not_to have_content('likes')
    end



    context 'when current user likes it' do

      before do
        liked_comment.likers << user
        render :partial => 'likes/likes_display', :locals => { :liked_object => liked_comment }
      end

      it "displays 'You'" do
        expect(rendered).to have_content('You')
      end

      it "displays no other user names" do
        expect(rendered).not_to have_content(liked_comment.likers.first.profile.full_name)
      end

    end



    context 'when current user does not like it' do

      it "displays one user names" do
        render :partial => 'likes/likes_display', :locals => { :liked_object => liked_comment }
        expect(rendered).not_to have_content(liked_comment.likers[1].profile.full_name)
      end

    end

  end

end