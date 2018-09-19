require 'rails_helper'

describe DogPresenter, type: :model do
  before(:each) do
    @user = create(:user)
    @param_info = {'name' => 'Salome',
    'size' => 'M', 'id' => '30176972', 'sex' => 'F',
    'breed' => 'Boxer', 'location' => '80209'}
    @presenter = DogPresenter.new(@user, @param_info)
  end
  it 'it can find a shelter' do
    VCR.use_cassette('shelter-presenter') do
      expect(@presenter.shelter).to be_a(Shelter)
    end
  end
  it 'it can find location of dog' do
    VCR.use_cassette('contact-geocoder') do
      expect(@presenter.contact_geocoder).to have_key("lat")
      expect(@presenter.contact_geocoder).to have_key("lon")
      expect(@presenter.shelter_coordinates).to eq(['39.7068', '-104.9653'])
    end
  end
end
