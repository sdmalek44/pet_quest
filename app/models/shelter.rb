class Shelter
  attr_reader :latitude,
              :longitude,
              :name,
              :phone,
              :email

  def initialize(info)
    @name = info[:name][:$t]
    @phone = info[:phone][:$t]
    @email = info[:email][:$t]
    @latitude = info[:latitude][:$t]
    @longitude = info[:longitude][:$t]
  end

end
