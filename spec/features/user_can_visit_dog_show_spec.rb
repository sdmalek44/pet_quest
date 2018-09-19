require 'rails_helper'

describe 'user visits /search/dogs' do
  it 'can see information about individual dog' do

    VCR.use_cassette('dog-show') do
      visit '/search/dogs/42452171'

      expect(page).to have_content('Amelia')
      expect(page).to have_content('Boxer')
      expect(page).to have_content('Adult - Female - Medium sized')

      expect(page).to have_content('HO-BO Care Boxer Rescue')
      expect(page).to have_content('(303) 744-8329')
      expect(page).to have_content('info@hobocare.org')
      expect(page).to have_content('Denver, CO 80209')

      expect(page).to have_content('Bio')

      expect(page).to have_link('View Book', count: 3)
      expect(page).to have_css('.book-box', count: 3)
      expect(page).to have_content('Here Are Some Great Resources about owning a Boxer Dog')
      expect(page).to have_content('Training Your Boxer')
      expect(page).to have_content('2001')
      expect(page).to have_content('Covers training tools, handling techniques, obedience exercises, socialization, and aggression problems.')
    end
  end
  it 'can find the individual dog even if the search by dog id fails' do
    VCR.use_cassette('bad-dog-show') do
      visit '/search/dogs/42334243?age=Senior&breed=American+Hairless+Terrier&location=13814&name=Roscoe+B.+DeMille&sex=M&size=S'

      expect(page).to have_content('Roscoe B. DeMille')
      expect(page).to have_content('American Hairless Terrier')
      expect(page).to have_content('Senior - Male - Small sized')
      expect(page).to have_content('North Norwich, NY 13814')
      expect(page).to have_content('baldisbeautifuldogrescue@gmail.com')
    end
  end
end
