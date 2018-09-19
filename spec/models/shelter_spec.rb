require 'rails_helper'

describe Shelter, type: :model do
  before(:each) do
    @param_info = {
                  id: { :$t => '1'},
                  name: { :$t => 'bob'},
                  email: { :$t => 'bob@bob'},
                  phone: { :$t => '111' },
                  latitude: { :$t => '1' },
                  longitude: { :$t => '2'}
                  }
    @shelter = Shelter.new(@param_info)
  end

  it 'has attributes' do
    expect(@shelter.id).to eq('1')
    expect(@shelter.name).to eq('bob')
    expect(@shelter.email).to eq('bob@bob')
    expect(@shelter.phone).to eq('111')
    expect(@shelter.latitude).to eq('1')
    expect(@shelter.longitude).to eq('2')
  end
end
