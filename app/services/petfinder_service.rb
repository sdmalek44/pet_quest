class PetfinderService

  def initialize(param_info = {})
    @param_info = param_info.to_h
    @location = @param_info.delete('location') || 80209
    @name = @param_info.delete('name')
  end

  def search_query
    search_params.inject("") do |collector, (key, value)|
      collector += "#{key}=#{value}&" unless value.empty?
      collector
    end.chop!
  end

  def animal_query
    animal_params.inject("") do |collector, (key, value)|
      collector += "#{key}=#{value}&" unless value.empty?
      collector
    end.chop!
  end

  def user_location
    unless @param_info['latitude'].nil? || @param_info['latitude'].empty?
      Geocoder.search([@param_info['latitude'], @param_info['longitude']]).first.data['address']['postcode']
    else
      @location.to_s
    end
  end

  def animals(animal)
    @animals ||= get_json("/pet.find?key=#{ENV['PET_FINDER_TOKEN']}&animal=#{animal}&location=#{user_location}&#{search_query}&format=json&output=full")[:petfinder][:pets][:pet]
    return [] if @animals.nil?
    return [@animals] if @animals.class == Hash
    return @animals if @animals.class == Array
  end

  def breeds(animal)
    @breeds ||= get_json("/breed.list?key=#{ENV['PET_FINDER_TOKEN']}&animal=#{animal}&format=json")[:petfinder][:breeds][:breed]
  end

  def animal
    @animal ||= get_json("/pet.get?key=#{ENV['PET_FINDER_TOKEN']}&#{animal_query}&format=json")[:petfinder][:pet]
  end

  def animal_hard_way(type)
    @animal ||= animals(type).select {|animal| animal[:name][:$t] == @name }.first
  end

  def shelter(shelter_id)
    @shelter ||= get_json("/shelter.get?key=#{ENV['PET_FINDER_TOKEN']}&id=#{shelter_id}&format=json")[:petfinder][:shelter]
  end

  def shelters(zip_code)
    @shelters ||= get_json("/shelter.find?key=#{ENV['PET_FINDER_TOKEN']}&location=#{zip_code}&count=3&format=json")[:petfinder][:shelters][:shelter]
  end

  def shelter_animals(shelter_id)
    @shelter_animals ||= get_json("/shelter.getPets?key=#{ENV['PET_FINDER_TOKEN']}&id=#{shelter_id}&count=1000&format=json")[:petfinder][:pets][:pet]
  end

  private

  def search_params
    @sp ||= @param_info.select {|k,v| ["size", "breed", "age", "sex"].include?(k) }
  end

  def animal_params
    @ap ||= @param_info.select {|k,v| ["id"].include?(k) }
  end

  def conn
    @conn ||= Faraday.new(url: "http://api.petfinder.com") { |faraday| faraday.adapter Faraday.default_adapter }
  end

  def get_json(url)
    JSON.parse(conn.get(url).body, symbolize_names: true)
  end
end
