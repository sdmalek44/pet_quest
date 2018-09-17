require 'rails_helper'

describe 'user visits /search/dogs' do
  it 'can see information about individual dog' do
    bio = "Sign In\nAmelia\nBoxer\nAdult - Female - Medium sized\nDenver, "\
    "CO 80209\nContact Info\n(303) 744-8329\ninfo@hobocare.org\nBio\nI am a "\
    "5-6 year old fawn female Boxer. I am very sweet even though I have had a "\
    "very rough life. I have only lived outside and I am full of scars. I am "\
    "great with other dogs and seem to be ok with cats too. PLEASE READ BELOW "\
    "PRIOR TO EMAILING IN! If you are interested in adopting this dog or any "\
    "others, please go to www.hobocare.org to review our home requirements "\
    "and fill out an application. Please do not email and ask for more "\
    "information on how to adopt, all the information is already available "\
    "online. The information you see here is all that is currently available "\
    "about this dog. No boxers are adopted without a completed application "\
    "and home check. Our adoption fee is a minimum of $250.00."

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
      expect(page).to have_content(bio)

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
