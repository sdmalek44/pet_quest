require 'rails_helper'

describe NullPhotoAlbum, type: :model do
  it 'gets default thumbnail photo and profile photo' do
    pa = NullPhotoAlbum.new

    expect(pa.thumbnail_photo).to eq("http://photos.petfinder.com/photos/pets/42615260/1/?bust=1535959630&width=500&-x.jpg")
    expect(pa.profile_photo).to eq("http://photos.petfinder.com/photos/pets/42615260/1/?bust=1535959630&width=500&-x.jpg")
  end
end
