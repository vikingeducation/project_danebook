require 'rails_helper'


describe "likes/_likes_display.html.erb" do


  context 'when viewing a Post with a lot of likes' do

    it "conjugates verb as 'like'"


    context 'when current user likes it' do

      it "displays 'You'"

      it "displays at one user name"

    end

    context 'when current user does not like it' do

      it "displays two user names"

      it "conjugates verb as 'like'"

    end

  end


  context 'when viewing a Comment with a lot of likes' do

    it "conjugates verb as 'like'"


    context 'when current user likes it' do

      it "displays 'You'"

      it "displays no other user names"

    end

    context 'when current user does not like it' do

      it "displays no user names"

    end

  end

end