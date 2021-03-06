#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/dcbang for more book information.
#---
require 'rails_helper'

feature "dashboard" do
  scenario "sign up, go to the homepage, log out" do
    visit "/"
    expect(page).to have_content("Log in")
    screenshot! filename: "sign-in.png"
    click_link "Sign up"
    screenshot! filename: "sign-up.png"
    email = "user#{rand(10000)}@example.com"
    fill_in "Email", with: email
    fill_in "Password",with: "1234qwert"
    fill_in "Password confirmation",with: "1234qwert"
    click_button "Sign up"
    within "header" do
      expect(page).to have_content("Welcome to Shine, #{email}")
    end
    within "section" do
      expect(page).to have_content("Future home of Shine's Dashboard")
    end
    screenshot! filename: "dashboard.png"
    click_link "Log Out"
    expect(page).not_to have_content("Welcome to Shine")
    expect(page).to have_content("Log in")
  end

  scenario "log in incorrectly" do
    visit "/"
    expect(page).to have_content("Log in")
    click_button "Log in"
    screenshot! filename: "sign-in-error.png"
    expect(page).to have_content("Invalid email or password")
  end
end
