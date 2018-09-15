class Contact
  attr_reader :number,
              :state,
              :email,
              :city,
              :zip,
              :street

  def initialize(info)
    @number = info[:phone][:$t] if info[:phone][:$t]
    @state = info[:state][:$t] if info[:state][:$t]
    @email = info[:email][:$t] if info[:email][:$t]
    @city = info[:city][:$t] if info[:city][:$t]
    @zip = info[:zip][:$t] if info[:zip][:$t]
    @street = info[:address1][:$t] if info[:address1][:$t]
  end

  def city_state_zip
    "#{@city}, #{@state} #{@zip}"
  end

  def geo_location_info
    "#{@city}, #{@state}, #{@zip}"
  end

  def full_address
    "#{@street} #{@city}, #{@state} #{@zip}"
  end
end
