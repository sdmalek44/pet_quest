class Book
  attr_reader :title,
              :authors,
              :date,
              :description,
              :link

  def initialize(book_info)
    @title = book_info[:volumeInfo][:title]
    @authors = book_info[:volumeInfo][:authors]
    @date = book_info[:volumeInfo][:publishedDate]
    @description = book_info[:volumeInfo][:description]
    @link = book_info[:volumeInfo][:canonicalVolumeLink]
    @image = book_info[:volumeInfo][:imageLinks][:thumbnail]
  end

  def image(size = 1)
    @image.gsub("zoom=1", "zoom=#{size}")
  end

end
