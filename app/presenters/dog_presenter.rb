class DogPresenter < BasePresenter

  def initialize(user, param_info = {})
    @pet_service = PetfinderService.new(param_info)
    super(user)
  end

  def animal_type
    'dog'
  end

  def shelter
    shelter_info = @pet_service.shelter(dog.shelter_id)
    Shelter.new(shelter_info) if shelter_info
  end

  def contact_geocoder
    geo_info = Geocoder.search(dog.contact.geo_location_info).first
    @geocoder ||= geo_info.data if geo_info
  end

  def shelter_coordinates
    return [shelter.latitude, shelter.longitude] if shelter
    [contact_geocoder['lat'], contact_geocoder['lon']] if contact_geocoder
  end

  def dog
    if @pet_service.animal
      @dog ||= Dog.new(@pet_service.animal)
    elsif @pet_service.animal_hard_way('dog')
      @dog ||= Dog.new(@pet_service.animal_hard_way('dog'))
    end
  end

  def books(num = 3)
    book_service.training_books('dog', dog.breeds.first).shift(num).map do |book_info|
      Book.new(book_info)
    end
  end

  private

  def book_service
    @book_service ||= BookService.new
  end
end
