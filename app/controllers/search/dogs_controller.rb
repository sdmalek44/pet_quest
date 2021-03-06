class Search::DogsController < ApplicationController

  def index
    @presenter = DogSearchPresenter.new(current_user, search_params)
  end

  def show
    @presenter = DogPresenter.new(current_user, dog_params)
  end

  private

  def search_params
    params.permit(:breed, :age, :size, :sex, :latitude, :longitude)
  end

  def dog_params
    params.permit(:id, :name, :location, :size, :breed, :age, :sex)
  end
end
