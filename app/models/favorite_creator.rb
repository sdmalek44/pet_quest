class FavoriteCreator < BasePresenter

  def initialize(user, param_info = {})
    @pet_service = PetfinderService.new(param_info)
    @param_info = param_info.to_h
    @pet_type = @param_info[:type]
    super(user)
  end

  def pet
    pet = @pet_type.titleize.constantize
    if @pet_service.animal
      @pet ||= pet.new(@pet_service.animal)
    elsif @pet_service.animal_hard_way(@pet_type.downcase)
      @pet ||= pet.new(@pet_service.animal_hard_way(@pet_type.downcase))
    end
  end

  def add_favorite
    user.favorites.find_by(pet_id: pet.id) ||
    user.favorites.create(pet_id: pet.id, name: pet.name, breeds: breeds_string,
                          age: pet.age, sex: pet.sex, location: pet.contact.city_state_zip,
                          status: pet.status)
  end

  def breeds_string
    pet.breeds.join(", ")
  end

  def breed
    pet.breeds.first.gsub(" ", "+")
  end

  def build_redirect
    "/search/#{@pet_type}s?latitude=#{@param_info[:latitude]}
&longitude=#{@param_info[:longitude]}&breed=#{@param_info[:breed]}
&age=#{@param_info[:age]}&size=#{@param_info[:size]}&sex=#{@param_info[:sex]}"
  end

end
