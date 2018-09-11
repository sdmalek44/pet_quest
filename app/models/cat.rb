class Cat
  attr_reader :contact,
              :name,
              :age,
              :sex,
              :size,
              :photos,
              :id,
              :description,
              :last_update,
              :breeds

  def initialize(info)
    @contact = Contact.new(info[:contact]) if info[:contact]
    @age = info[:age][:$t]
    @name = info[:name][:$t]
    @sex = convert_gender[info[:sex][:$t]]
    @size = convert_size[info[:size][:$t]]
    @photos = PhotoAlbum.new(info[:media]) unless info[:media].empty?
    @photos = NullPhotoAlbum.new if info[:media].empty?
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

  def convert_size
    { "S" => "Small",
      "M" => "Medium",
      "L" => "Large",
      "XL" => "Very Large"
    }
  end

  def convert_gender
    {
      "M" => "Male",
      "F" => "Female"
    }
  end
end
