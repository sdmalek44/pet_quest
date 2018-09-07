require 'rails_helper'

RSpec.feature "user logs in" do
  scenario "using rspec oauth" do
    user = create(:user)
    stub_omniauth

    visit root_path

    expect(page).to have_link("Sign In")
    click_link "Sign In"

    expect(page).to have_content("Welcome, Stephen")
    expect(page).to have_link("Logout")
  end
end
