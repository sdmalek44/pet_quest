require 'rails_helper'

RSpec.feature "user logs in" do
  scenario "using rspec oauth can log in and out" do
    user = create(:user)
    stub_omniauth

    visit root_path

    expect(page).to have_link("Sign In")
    click_link "Sign In"

    expect(page).to have_content("Welcome, Stephen")
    expect(page).to have_link("Sign Out")

    click_link "Sign Out"

    expect(current_path).to eq('/')
  end
  scenario "user logs in from different page" do
    user = create(:user)
    stub_omniauth

    VCR.use_cassette('dog-login') do
      allow_any_instance_of(ActionDispatch::Request::Session).to receive(:[]).and_return('/search/dogs')

      visit '/search/dogs'

      click_link "Sign In"

      expect(current_path).to eq('/search/dogs')
    end
  end
end
