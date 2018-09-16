class Default::FavoritesController < ApplicationController

  def create
    fc = FavoriteCreator.new(current_user, favorite_params)
    fc.add_favorite
    redirect_to fc.build_redirect
  end

  private

  def favorite_params
    params.permit(:id, :name, :location, :size, :breed, :age, :sex, :type)
  end
end
