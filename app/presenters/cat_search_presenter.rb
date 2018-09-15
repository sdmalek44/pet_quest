class CatSearchPresenter < BasePresenter
  attr_reader :service

  def initialize(user, param_info = {})
    @service = PetfinderService.new(param_info)
    super(user)
  end

  def cats
    service.animals('cat').map { |cat_info| Cat.new(cat_info) }
  end

  def breeds
    service.breeds('cat').map {|breed_info| Breed.new(breed_info[:$t])}
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
