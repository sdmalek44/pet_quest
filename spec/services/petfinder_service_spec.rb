require 'rails_helper'

describe PetfinderService, type: :model do
  before(:each) do
    @user = create(:user)
    @param_info = {'name' => 'BILL NYE', 'latitude' => '39.7497343', 'longitude' => '-105.00008249999999',
    'size' => 'S', 'age' => 'Young', 'sex' => 'M'}
    @service = PetfinderService.new(@param_info)

  end
  it 'can build a search query' do
    expected = "size=S&age=Young&sex=M"

    expect(@service.search_query).to eq(expected)
  end
  it 'can find user zip code from coordinates' do

    expect(@service.user_location).to eq("80202")
  end
  it 'can find a list of animals' do
    VCR.use_cassette('dogs-list') do
      animals = @service.animals('dog')
      animal = animals.first

      expect(animals).to be_a(Array)
      expect(animals.count).to eq(25)
      expect(animal).to have_key(:status)
      expect(animal).to have_key(:contact)
      expect(animal).to have_key(:age)
      expect(animal).to have_key(:name)
      expect(animal).to have_key(:sex)
      expect(animal).to have_key(:size)
      expect(animal).to have_key(:media)
      expect(animal).to have_key(:id)
      expect(animal).to have_key(:shelterId)
      expect(animal).to have_key(:breeds)
      expect(animal).to have_key(:description)
      expect(animal).to have_key(:lastUpdate)
    end
  end
  it 'can find one animal the long way' do
    VCR.use_cassette('dogs-list') do
      animal = @service.animal_hard_way('dog')

      expect(animal).to be_a(Hash)
      expect(animal[:name][:$t]).to eq('BILL NYE')
    end
  end
  it 'can find shelter animals' do
    VCR.use_cassette('shelter-animals') do
      shelter_animals = @service.shelter_animals('CO178')
      animal = shelter_animals.first

      expect(animal).to have_key(:status)
      expect(animal).to have_key(:contact)
      expect(animal).to have_key(:age)
      expect(animal).to have_key(:name)
      expect(animal).to have_key(:sex)
      expect(animal).to have_key(:size)
      expect(animal).to have_key(:media)
      expect(animal).to have_key(:id)
      expect(animal).to have_key(:shelterId)
      expect(animal).to have_key(:breeds)
      expect(animal).to have_key(:description)
      expect(animal).to have_key(:lastUpdate)
    end
  end
  it 'can find shelters by zip' do
    VCR.use_cassette('shelters-zip') do
      shelters = @service.shelters('80209')
      shelter = shelters.first

      expect(shelter).to have_key(:id)
      expect(shelter).to have_key(:name)
      expect(shelter).to have_key(:phone)
      expect(shelter).to have_key(:email)
      expect(shelter).to have_key(:latitude)
      expect(shelter).to have_key(:longitude)
    end
  end
end
