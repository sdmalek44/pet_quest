class Favorite < ApplicationRecord
  belongs_to :user

  def breed_list
    breeds.split(', ')
  end

  def display_name
    pet_name = name
    return pet_name[0..14] + "..." if pet_name.length > 14
    pet_name
  end

  def zip
    location[-5..-1] if location
  end
end
