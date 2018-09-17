require 'rails_helper'

describe 'user visits /search/cats/:id' do
  it 'can see information about individual cat' do
    VCR.use_cassette('cat-show') do
      visit '/search/cats/34031773'

      expect(page).to have_content('Santos')
      expect(page).to have_content('Tabby')
      expect(page).to have_content('Adult - Male - Medium sized')

      expect(page).to have_content('Barnwater Cats Rescue Organization')
      expect(page).to have_content('(303) 759-2855')
      expect(page).to have_content('barnwatercat@aol.com')
      expect(page).to have_content('Denver, CO 80210')

      expect(page).to have_content('Bio')

      expect(page).to have_link('View Book', count: 3)
      expect(page).to have_css('.book-box', count: 3)
      expect(page).to have_content('Here Are Some Great Resources about owning a Tabby Cat')
      expect(page).to have_content('The Trainable Cat')
      expect(page).to have_content('2016-09-13')
      expected = 'But in The Trainable Cat, bestselling anthrozoologist John '\
                 'Bradshaw and cat expert Sarah Ellis show that cats '\
                 'absolutely must be trained in order to enrich the bond '\
                 'between pet and owner.'
      expect(page).to have_content(expected)
    end
  end
  it 'can find the individual dog even if the search by dog id fails' do
    VCR.use_cassette('bad-cat-show') do
      visit '/search/cats/36388158?age=Adult&breed=Maine+Coon&location=80209&name=CO+-+Whiskey+Jack+%28CP%29&sex=M&size=L'

      expect(page).to have_content('CO - Whiskey Jack (CP)')
      expect(page).to have_content('Maine Coon')
      expect(page).to have_content('Adult - Male - Large sized')
      expect(page).to have_content('Denver, CO 80209')
      expect(page).to have_content('rescue@mainecoonrescue.net')
    end
  end
end
