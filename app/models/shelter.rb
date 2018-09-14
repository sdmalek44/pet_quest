class Shelter
  attr_reader :latitude,
              :longitude,
              :name,
              :phone,
              :email

  def initialize(info)
    @name = info[:name][:$t] if info[:name][:$t]
    @phone = info[:phone][:$t] if info[:phone][:$t]
    @email = info[:email][:$t] if info[:email][:$t]
    @latitude = info[:latitude][:$t] if info[:latitude][:$t]
    @longitude = info[:longitude][:$t] if info[:longitude][:$t]
  end

end
