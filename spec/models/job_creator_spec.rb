require 'rails_helper'

describe JobCreator, type: :model do

  before(:each) do
    @user = create(:user)
    @jc = JobCreator.new(@user)
  end

  it 'can make new pets' do
    VCR.use_cassette('make-pets') do
      expect(@jc.new_pets.count).to eq(3)
    end
  end
end
