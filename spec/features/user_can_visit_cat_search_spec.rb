require 'rails_helper'

describe 'User visits /search/cats' do
  it 'can search cats by parameters' do
    VCR.use_cassette('cat-search') do
      visit '/search/cats'

      expect(page).to have_css('.card-link', count: 25)
    end
  end
end
