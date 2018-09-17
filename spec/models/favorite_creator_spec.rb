require 'rails_helper'

describe FavoriteCreator, type: :model do
  before(:each) do
    @user = create(:user)
    @param_info = {'id' => '42334243', 'age' => 'Senior',
                  'breed' => 'American Hairless Terrier',
                  'location' => '13814', 'name' => 'Roscoe B. DeMille',
                  'sex' => 'M', 'size' => 'S', 'type' => 'dog'}
    @fc = FavoriteCreator.new(@user, @param_info)
  end
  it 'can get a pet' do

    VCR.use_cassette('rosco') do
      pet = @fc.pet
      expect(pet).to be_a(Dog)
      expect(pet.name).to eq('Roscoe B. DeMille')
    end
  end
  it 'can build a redirect path' do
    expected = "/search/dogs?age=Senior&breed=American Hairless Terrier&sex=M&size=S"
    expect(@fc.build_redirect).to eq(expected)
  end
end
