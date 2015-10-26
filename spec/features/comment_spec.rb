require 'spec_helper'
require 'rails_helper'

feature "comment" do
  scenario "commenting on a goal" do
      create_user
      add_goal
      click_link "Add Comment to this Goal"
      fill_in "Add Comment", with: "A comment"
      expect(page).to have_content("A comment")
  end

  scenario "commenting on a user" do
    create_user
    click_link "Add Comment to this User"
    fill_in "Add Comment", with: "A comment"
    expect(page).to have_content("A comment")
  end

  scenario "commenting while logged out" do
    create_user
    click_button "Sign Out"
    visit user_url(1)
    click_link "Add Comment to this User"
    expect(page).to have_content("Sign In")
  end

end
