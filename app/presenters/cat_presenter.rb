class CatPresenter < BasePresenter

  def initialize(user, param_info = {})
    @pet_service = PetfinderService.new(param_info)
    super(user)
  end

  def animal_type
    'cat'
  end

  def shelter
    shelter_info = @pet_service.shelter(cat.shelter_id)
    Shelter.new(shelter_info) if shelter_info
  end

  def cat
    if @pet_service.animal
      @cat ||= Cat.new(@pet_service.animal)
    elsif @pet_service.animal_hard_way('cat')
      @cat ||= Cat.new(@pet_service.animal_hard_way('cat'))
    end
  end

  def contact_geocoder
    @geocoder ||= Geocoder.search(cat.contact.geo_location_info).first.data
  end

  def shelter_coordinates
    return [shelter.latitude, shelter.longitude] if shelter
    [contact_geocoder['lat'], contact_geocoder['lon']]
  end

  def books(num = 3)
    book_service.training_books('cat', cat.breeds.first).shift(num).map do |book_info|
      Book.new(book_info)
    end
  end

  private

  def book_service
    @book_service ||= BookService.new
  end

end
