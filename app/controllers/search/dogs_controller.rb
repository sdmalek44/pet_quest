class Search::DogsController < ApplicationController

  def index
    if search_params[:breed]
      query = search_params.to_h.inject("") do |collector, (key, value)|
        collector += "#{key}=#{value}&" unless value.empty?
        collector
      end.chop!

      conn = Faraday.new(url: "http://api.petfinder.com") { |faraday| faraday.adapter Faraday.default_adapter }
      response = conn.get("/pet.find?key=#{ENV['PET_FINDER_TOKEN']}&animal=dog&location=80209&#{query}&format=json&output=full")
      dogs_info = JSON.parse(response.body, symbolize_names: true)[:petfinder][:pets][:pet]

      @dogs = dogs_info.map { |dog_info| Dog.new(dog_info) }
    end

  end

  def show
    query = ""
    show_params.each { |key, value| query += "#{key}=#{value}&" unless value.empty? }
    query.chop!
    conn = Faraday.new(url: "http://api.petfinder.com") { |faraday| faraday.adapter Faraday.default_adapter }
    response = conn.get("/pet.get?key=#{ENV['PET_FINDER_TOKEN']}&#{query}&format=json")
    dog_info = JSON.parse(response.body, symbolize_names: true)[:petfinder][:pet]
    @dog = Dog.new(dog_info)
  end

  private

  def presenter
    @presenter ||= DogSearchPresenter.new(current_user)
  end

  def search_params
    params.permit(:breed, :age, :size, :sex)
  end

  def show_params
    params.permit(:id)
  end
end
