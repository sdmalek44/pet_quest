class Favorite < ApplicationRecord
  belongs_to :user

  def breed_list
    breeds.split(', ')
  end

  def zip
    location[-5..-1]
  end
end
