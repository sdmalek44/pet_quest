require 'rails_helper'

RSpec.feature "user logs in" do
  scenario "using rspec oauth can log in and out" do
    user = create(:user)
    stub_omniauth

    visit root_path

    expect(page).to have_button("Sign In")
    click_button "Sign In"

    expect(page).to have_content("Welcome, Stephen")
    expect(page).to have_link("Sign Out")

    click_link "Sign Out"

    expect(current_path).to eq('/')
  end
end
