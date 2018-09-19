class Shelter
  attr_reader :latitude,
              :longitude,
              :name,
              :phone,
              :email,
              :id

  def initialize(info)
    @id = info[:id][:$t] if info[:id]
    @name = info[:name][:$t] if info[:name][:$t]
    @phone = info[:phone][:$t] if info[:phone][:$t]
    @email = info[:email][:$t] if info[:email][:$t]
    @latitude = info[:latitude][:$t] if info[:latitude][:$t]
    @longitude = info[:longitude][:$t] if info[:longitude][:$t]
  end

end
