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
    dogs_info = get_json("/pet.find?key=#{ENV['PET_FINDER_TOKEN']}&animal=dog&location=80209&#{build_query}&format=json&output=full")[:petfinder][:pets][:pet]
    dogs_info.map { |dog_info| Dog.new(dog_info) }
  end

  def breeds
    breeds_info = get_json("/breed.list?key=#{ENV['PET_FINDER_TOKEN']}&animal=dog&format=json")[:petfinder][:breeds][:breed]
    breeds_info.map {|breed_info| Breed.new(breed_info[:$t])}
  end

  def dog
    dog_info = get_json("/pet.get?key=#{ENV['PET_FINDER_TOKEN']}&#{build_query}&format=json")[:petfinder][:pet]
    Dog.new(dog_info)
  end

  private

  def conn
    @conn ||= Faraday.new(url: "http://api.petfinder.com") { |faraday| faraday.adapter Faraday.default_adapter }
  end

  def get_json(url)
    JSON.parse(conn.get(url).body, symbolize_names: true)
  end
end
