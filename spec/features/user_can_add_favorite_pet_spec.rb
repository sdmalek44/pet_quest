require 'rails_helper'

describe 'registered user' do
  context 'visits /search/dogs' do
    it 'can click a button on a dog that adds it to favorites' do
      VCR.use_cassette('dog-search') do
        user = create(:user)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit '/search/dogs'

        within('.pet-42473914') do
          click_on "Add to Favorites"
        end

        expect(current_path).to eq('/search/dogs')
        expect(page).to have_content('Successfully added', 'to Favorites')

        click_on 'My Favorites'

        expect(current_path).to eq("/favorites/#{user.id}")
        expect(page).to have_css(".pet-42473914")
      end
    end
  end
end
