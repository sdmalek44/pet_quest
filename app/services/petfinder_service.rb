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

  def user_location
    unless @param_info[:latitude].nil? || @param_info[:latitude].empty?
      Geocoder.search([@param_info[:latitude], @param_info[:longitude]]).first.data['address']['postcode']
    else
      80209
    end
  end

  def animals(animal)
    @animals ||= get_json("/pet.find?key=#{ENV['PET_FINDER_TOKEN']}&animal=#{animal}&location=#{user_location}&#{build_query}&format=json&output=full")[:petfinder][:pets][:pet]
    return [] if @animals.nil?
    return @animals if @animals.class == Array
    return [@animals] if @animals.class == Hash
  end

  def breeds(animal)
    @breeds ||= get_json("/breed.list?key=#{ENV['PET_FINDER_TOKEN']}&animal=#{animal}&format=json")[:petfinder][:breeds][:breed]
  end

  def animal
    @animal ||= get_json("/pet.get?key=#{ENV['PET_FINDER_TOKEN']}&#{build_query}&format=json")[:petfinder][:pet]
  end

  def shelter(shelter_id)
    @shelter ||= get_json("/shelter.get?key=#{ENV['PET_FINDER_TOKEN']}&id=#{shelter_id}&format=json")[:petfinder][:shelter]
  end

  private

  def conn
    @conn ||= Faraday.new(url: "http://api.petfinder.com") { |faraday| faraday.adapter Faraday.default_adapter }
  end

  def get_json(url)
    JSON.parse(conn.get(url).body, symbolize_names: true)
  end
end
