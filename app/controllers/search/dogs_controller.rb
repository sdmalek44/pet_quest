class Search::DogsController < ApplicationController

  def index
    if search_params[:breed]
      query = ""
      search_params.each { |key, value| query += "#{key}=#{value}&" unless value.empty? }
      query.chop!

      conn = Faraday.new(url: "http://api.petfinder.com") { |faraday| faraday.adapter Faraday.default_adapter }
      zip = 80209
      response = conn.get("/pet.find?key=#{ENV['PET_FINDER_TOKEN']}&animal=dog&location=#{zip}&#{query}&format=json&output=full")
      dogs_info = JSON.parse(response.body, symbolize_names: true)[:petfinder][:pets][:pet]

      @dogs = dogs_info.map { |dog_info| Dog.new(dog_info) }
    end

  end

  def create

  end

  private

  def presenter
    @presenter ||= DogSearchPresenter.new(current_user)
  end

  def search_params
    params.permit(:breed, :age, :size, :gender)
  end
end
