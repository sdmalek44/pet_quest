class CatSearchPresenter < BasePresenter

  def initialize(user, param_info = {})
    @service = PetfinderService.new(param_info)
    super(user)
  end

  def cats
    @cats ||= service.animals('cat').map { |cat_info| Cat.new(cat_info) }
  end

  def breeds
    service.breeds('cat').map {|breed_info| Breed.new(breed_info[:$t])}
  end
  
  attr_reader :service
end
