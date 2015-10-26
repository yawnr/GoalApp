
require 'spec_helper'
require 'rails_helper'

feature "goals" do
  before do
    create_user
  end

  scenario "has goal section" do
    expect(page).to have_content("Goals")
  end

  scenario "adding goal to goals" do
    add_goal
    expect(page).to have_content("1. Do some stuff today.")
  end

  scenario "making a goal public" do
    fill_in "New Goal", with: "Do some stuff today."
    select('Public', :from => "Flag")
    click_button "Create Goal"
    expect(page).to have_content("1. Do some stuff today. -- Public")
  end

  scenario "goal defaulting to private" do
    add_goal
    expect(page).to have_content("1. Do some stuff today. -- Private")
  end

  scenario "marking a goal completed" do
    add_goal
    check('Completed?')
    expect(page).to have_checked_field("Completed?")
  end

  scenario "deleting goals" do
    add_goal
    click_button "Delete Goal"
    expect(page).not_to have_content("1. Do some stuff today.")
  end

  scenario "changing goal text" do
    add_goal
    click_link('Edit')
    fill_in "Edit Goal", with: "Do some other stuff today."
    click_button("Edit Goal")
    expect(page).to have_content("1. Do some other stuff today.")

  end

  scenario "other users cannot view private goals" do
    add_goal
    click_button("Sign Out")

    create_other_user
    bw = User.find_by_username!('BarryWhite')
    visit(user_url(bw))

    expect(page).not_to have_content("1. Do some stuff today.")
  end

  scenario "displays all goals on user page" do
    add_goal
    fill_in "New Goal", with: "Do some different stuff today."
    select('Public', :from => "Flag")
    click_button "Create Goal"

    expect(page).to have_content("1. Do some stuff today.")
    expect(page).to have_content("2. Do some different stuff today.")
  end



end
