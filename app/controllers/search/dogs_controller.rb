class Search::DogsController < ApplicationController

  def index
  end

  def show
    query = ""
    show_params.each { |key, value| query += "#{key}=#{value}&" unless value.empty? }
    query.chop!
    conn = Faraday.new(url: "http://api.petfinder.com") { |faraday| faraday.adapter Faraday.default_adapter }
    response = conn.get("/pet.get?key=#{ENV['PET_FINDER_TOKEN']}&#{query}&format=json")
    dog_info = JSON.parse(response.body, symbolize_names: true)[:petfinder][:pet]

    @dog = Dog.new(dog_info) if dog_info
  end

  private

  def presenter
    @presenter ||= DogSearchPresenter.new(current_user, search_params)
  end

  def search_params
    params.permit(:breed, :age, :size, :sex)
  end

  def show_params
    params.permit(:id)
  end
end
