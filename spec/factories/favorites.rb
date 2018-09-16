FactoryBot.define do
  factory :favorite do
    pet_id '124'
    breeds 'boxer'
    name 'dan'
    size 'Small'
    age 'Young'
    sex 'Male'
    location 'Denver, CO 80209'
    status 'A'
    pet_type 'dog'
    photo 'http://photos.petfinder.com/photos/pets/41016631/1/?bust=1534988024&width=300&-pn.jpg'
    user nil
  end
end
