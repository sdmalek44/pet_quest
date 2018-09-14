class Book
  attr_reader :title,
              :authors,
              :date,
              :snippet,
              :link

  def initialize(book_info)
    @title = book_info[:volumeInfo][:title]
    @authors = book_info[:volumeInfo][:authors]
    @date = book_info[:volumeInfo][:publishedDate]
    @snippet = book_info[:searchInfo][:textSnippet]
    @link = book_info[:volumeInfo][:infoLink]
    @image = book_info[:volumeInfo][:imageLinks][:thumbnail]
  end

  def image(size = 1)
    @image.gsub("zoom=1", "zoom=#{size}")
  end

end
