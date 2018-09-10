class Search::DogsController < ApplicationController

  def index
  end

  def show
  end

  private

  def presenter
    @presenter ||= DogSearchPresenter.new(current_user, search_params)
  end

  def search_params
    params.permit(:breed, :age, :size, :sex, :id)
  end
end
