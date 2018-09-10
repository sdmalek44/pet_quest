class DogSearchPresenter < BasePresenter
  def initialize(user, param_info = {})
    @param_info = param_info.to_h
    super(user)
  end

  def build_query
    @param_info.inject("") do |collector, (key, value)|
      collector += "#{key}=#{value}&" unless value.empty?
      collector
    end.chop!
  end

  def dogs
    conn = Faraday.new(url: "http://api.petfinder.com") { |faraday| faraday.adapter Faraday.default_adapter }
    response = conn.get("/pet.find?key=#{ENV['PET_FINDER_TOKEN']}&animal=dog&location=80209&#{build_query}&format=json&output=full")
    dogs_info = JSON.parse(response.body, symbolize_names: true)[:petfinder][:pets][:pet]

    dogs_info.map { |dog_info| Dog.new(dog_info) }
  end
end
