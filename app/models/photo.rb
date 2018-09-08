class Photo
  attr_reader :id,
              :width,
              :url

  def initialize(info)
    @width = width_converter[info[:@size]]
    @url = info[:$t]
    @id = info[:@id].to_i
  end

  def width_converter
    {
      't' => 50,
      'pnt' => 60,
      'fpm' => 95,
      'pn' => 300,
      'x' => 500
    }
  end
end
