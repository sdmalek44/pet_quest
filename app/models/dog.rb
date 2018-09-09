class Dog
  attr_reader :contact,
              :name,
              :age,
              :sex,
              :size,
              :photos,
              :id,
              :description,
              :last_update

  def initialize(info)
    @contact = Contact.new(info[:contact]) if info[:contact]
    @age = info[:age][:$t]
    @name = info[:name][:$t]
    @sex = info[:sex][:$t]
    @size = convert_size[info[:size][:$t]]
    @photos = PhotoAlbum.new(info)
    @id = info[:id][:$t]
    @breeds = get_breeds(info[:breeds][:breed])
    @description = info[:description][:$t]
    @last_update = DateTime.parse(info[:lastUpdate][:$t]) if info[:lastUpdate][:$t]
  end

  def get_breeds(breed_info)
    if breed_info.class == Hash
      [breed_info[:$t]]
    elsif breed_info.class == Array
      breed_info.map { |info| info[:$t] }
    end
  end

  def breeds
    @breeds.join(", ") if @breeds
  end

  def convert_size
    { "S" => "Small",
      "M" => "Medium",
      "L" => "Large",
      "XL" => "Very Large"
    }
  end
end
