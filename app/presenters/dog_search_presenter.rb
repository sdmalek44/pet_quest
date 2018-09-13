class DogSearchPresenter < BasePresenter
  attr_reader :service

  def initialize(user, param_info = {})
    @service = PetfinderService.new(param_info)
    super(user)
  end

  def dogs
    if service.animals('dog')
      service.animals('dog').map { |dog_info| Dog.new(dog_info) }
    else
      []
    end
  end

  def breeds
    service.breeds('dog').map {|breed_info| Breed.new(breed_info[:$t])}
  end

  def shelter
    shelter_info = service.shelter(dog.shelter_id)
    Shelter.new(shelter_info)
  end

  def dog
    @dog ||= Dog.new(service.animal)
  end

end
