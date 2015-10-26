# spec/features/auth_spec.rb

require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "new user page" do
    visit new_user_url
    expect(page).to have_content("Username")
    expect(page).to have_content("Password")
  end

    feature "signing up a user" do
      scenario "shows username on the homepage after signup" do
        visit new_user_url
        fill_in "Username", with: "BarryWhite"
        fill_in "Password", with: "password"
        click_button "Sign Up"
        expect(page).to have_content("BarryWhite")
      end

      scenario "doesn't allow bad password" do
        visit new_user_url
        fill_in "Username", with: "BarryWhite"
        fill_in "Password", with: "pasrd"
        click_button "Sign Up"
        expect(page).to have_content("Password is too short")
      end

      scenario "doesn't allow blank username" do
        visit new_user_url
        fill_in "Username", with: ""
        fill_in "Password", with: "password"
        click_button "Sign Up"
        expect(page).to have_content("Username can't be blank")
      end
    end

end

feature "the login process" do

  before do
    visit new_user_url
    fill_in "Username", with: "BarryWhite"
    fill_in "Password", with: "password"
    click_button "Sign Up"
  end

  scenario "has a sign in page" do
    click_button "Sign Out"
    visit new_session_url
    expect(page).to have_content("Username")
    expect(page).to have_content("Password")
  end

  scenario "can login" do
    visit new_session_url
    fill_in "Username", with: "BarryWhite"
    fill_in "Password", with: "password"
    click_button "Sign In"
    expect(page).to have_content("BarryWhite")
  end

  scenario "yells at you for wrong login creds" do
    visit new_session_url
    fill_in "Username", with: "BarryWhite"
    fill_in "Password", with: "steve"
    click_button "Sign In"
    expect(page).to have_content("Username or Password Invalid")
  end

end

# feature "logging in" do
#
#   it "shows username on the homepage after login"
#
# end
#
# feature "logging out" do
#
#   it "begins with logged out state"
#
#   it "doesn't show username on the homepage after logout"
#
# end
