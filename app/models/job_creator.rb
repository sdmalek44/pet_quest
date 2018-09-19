class JobCreator
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def service
    @service ||= PetfinderService.new
  end

  def shelter
    @shelter ||= Shelter.new(service.shelter(service.shelters(@user.zip).second[:id][:$t]))
  end

  def pets_info
    @pets_info ||= service.shelter_animals(shelter.id).pop(10).reverse
  end

  def new_pets
    make_pets(pets_info).select do |pet|
      pet.last_update < DateTime.now && pet.last_update > 1.month.ago
    end
  end

  def make_pets(pets_info)
    pets_info.map do |pet_info|
      if pet_info[:animal][:$t] == 'Dog'
        Dog.new(pet_info)
      elsif pet_info[:animal][:$t] == 'Cat'
        Cat.new(pet_info)
      end
    end
  end

end
