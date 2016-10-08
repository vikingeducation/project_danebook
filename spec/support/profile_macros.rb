module ProfileMacros
  def edit_profile
    within(".edit_profile") do
      fill_in "profile[college]", with: "new college"
      fill_in "profile[hometown]", with: "new town"
      fill_in "profile[currently_lives]", with: "new living town"
      fill_in "profile[telephone]", with: "314-602-1544"
      fill_in "profile[words_to_live_by]", with: "new words to live by"
      fill_in "profile[about_me]", with: "new stuff about me"
    end
    click_button "Save Changes"
  end
end
