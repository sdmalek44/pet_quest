class CatSearchPresenter < BasePresenter
  attr_reader :service

  def initialize(user, param_info = {})
    @service = PetfinderService.new(param_info)
    super(user)
  end

  def cats
    service.animals('cat').map { |dog_info| Dog.new(dog_info) }
  end

  def breeds
    service.breeds('cat').map {|breed_info| Breed.new(breed_info[:$t])}
  end

  def cat
    Cat.new(service.animal)
  end
end
