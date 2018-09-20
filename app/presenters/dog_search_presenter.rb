class DogSearchPresenter < BasePresenter

  def initialize(user, param_info = {})
    @service = PetfinderService.new(param_info)
    super(user)
  end

  def dogs
    @dogs ||= @service.animals('dog').map { |dog_info| Dog.new(dog_info) }
  end

  def breeds
    @service.breeds('dog').map {|breed_info| Breed.new(breed_info[:$t])}
  end

  attr_reader :user
  attr_reader :service
end
