class CatSearchPresenter < BasePresenter
  attr_reader :service

  def initialize(user, param_info = {})
    @service = PetfinderService.new(param_info)
    super(user)
  end

  def cats
    if service.animals('cat')
      service.animals('cat').map { |cat_info| Cat.new(cat_info) }
    else
      []
    end
  end

  def breeds
    service.breeds('cat').map {|breed_info| Breed.new(breed_info[:$t])}
  end

  def shelter
    shelter_info = service.shelter(cat.shelter_id)
    Shelter.new(shelter_info)
  end

  def cat
    Cat.new(service.animal)
  end
end
