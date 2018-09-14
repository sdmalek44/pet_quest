class BookService

  def training_books(animal, breed)
    get_json("/books/v1/volumes?q=#{querify(breed)}+#{querify(animal)}+training")[:items]
  end

  def querify(str)
    str.gsub(" ","+")
  end

  private

  def get_json(url)
    JSON.parse(conn.get(url).body, symbolize_names: true)
  end

  def conn
    @conn ||= Faraday.new('https://www.googleapis.com') do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end

end
