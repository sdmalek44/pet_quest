require 'rails_helper'

describe Photo, type: :model do
  before(:each) do
    @param_info = {:@size => 't', :$t => 'www', :@id => '1'}
    @photo = Photo.new(@param_info)
  end
  it 'has attributes' do
    expect(@photo.id).to eq(1)
    expect(@photo.width).to eq(50)
    expect(@photo.url).to eq('www')
  end
  it 'converts width' do
    expected =   {
                    't' => 50,
                    'pnt' => 60,
                    'fpm' => 95,
                    'pn' => 300,
                    'x' => 500
                  }
    expect(@photo.width_converter).to eq(expected)
  end
end
