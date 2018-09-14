class Search::CatsController < ApplicationController

  def index
    @presenter = CatSearchPresenter.new(current_user, search_params)
  end

  def show
    @presenter = CatSearchPresenter.new(current_user, search_params)
  end

  private

  def search_params
    params.permit(:breed, :age, :size, :sex, :id, :latitude, :longitude)
  end
end
