class PetfinderService

  def initialize(param_info)
    @param_info = param_info.to_h
  end

  def build_query
    @param_info.inject("") do |collector, (key, value)|
      collector += "#{key}=#{value}&" unless value.empty?
      collector
    end.chop!
  end

  def animals(animal)
    get_json("/pet.find?key=#{ENV['PET_FINDER_TOKEN']}&animal=#{animal}&location=80209&#{build_query}&format=json&output=full")[:petfinder][:pets][:pet]
  end

  def breeds(animal)
    get_json("/breed.list?key=#{ENV['PET_FINDER_TOKEN']}&animal=#{animal}&format=json")[:petfinder][:breeds][:breed]
  end

  def animal
    get_json("/pet.get?key=#{ENV['PET_FINDER_TOKEN']}&#{build_query}&format=json")[:petfinder][:pet]
  end

  private

  def conn
    @conn ||= Faraday.new(url: "http://api.petfinder.com") { |faraday| faraday.adapter Faraday.default_adapter }
  end

  def get_json(url)
    JSON.parse(conn.get(url).body, symbolize_names: true)
  end
end
