require 'rails_helper'

describe 'registered user' do
  before(:each) do
    @user = create(:user)
    @favorite = create(:favorite, user_id: @user.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end
  context 'visits /search/dogs' do
    it 'can click a button on a dog that adds it to favorites' do
      VCR.use_cassette('dog-search') do

        visit '/search/dogs'

        within('.pet-42473914') do
          click_on "Add to Favorites"
        end

        expect(current_path).to eq('/search/dogs')
        expect(page).to have_content('Successfully added', 'to Favorites')

        click_on 'My Favorites'

        expect(current_path).to eq("/favorites/#{@user.id}")
        expect(page).to have_css(".pet-42473914")
      end
    end
  end
  context 'visit /favorites/:id' do
    it 'can click to remove a favorite pet' do

      visit "/favorites/#{@user.id}"

      expect(page).to have_content(@favorite.name)
      expect(page).to have_content(@favorite.breeds)
      expect(page).to have_content(@favorite.age)
      expect(page).to have_content(@favorite.sex)
      expect(page).to have_content(@favorite.location)

      click_on 'Remove Favorite'

      expect(current_path).to eq(favorites_path(id: @user.id))
      expect(page).to_not have_content(@favorite.age)
      expect(page).to_not have_content(@favorite.sex)
      expect(page).to_not have_content(@favorite.location)
    end
  end
end
