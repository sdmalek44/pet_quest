class DogSearchPresenter < BasePresenter
  attr_reader :service
  attr_reader :user

  def initialize(user, param_info = {})
    @service = PetfinderService.new(param_info)
    super(user)
  end

  def dogs
    dogs = @service.animals('dog').map { |dog_info| Dog.new(dog_info) }
  end

  def breeds
    @service.breeds('dog').map {|breed_info| Breed.new(breed_info[:$t])}
  end

end
