class Default::FavoritesController < Default::BaseController
  before_action :verify_user, only: [:create, :destroy]
  before_action :correct_user, only: [:show]

  def create
    fc = FavoriteCreator.new(current_user, create_favorite_params)
    fc.add_favorite
    flash[:notice] = "Successfully added #{fc.pet.name} to Favorites"
    redirect_to fc.build_redirect
  end

  def show
    @presenter = FavoritesPresenter.new(current_user)
  end

  def destroy
    favorite = current_user.favorites.find(params[:fav_id])
    flash[:notice] = "Successfully Removed #{favorite.name}"
    favorite.destroy
    redirect_to "/favorites/#{current_user.id}"
  end

  private

  def create_favorite_params
    params.permit(:id, :name, :location, :size,
      :breed, :age, :sex, :type, :latitude, :longitude)
  end
end
