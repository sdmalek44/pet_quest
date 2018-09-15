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
    @snippet = get_snippet(book_info)
    @link = book_info[:volumeInfo][:infoLink]
    @image = book_info[:volumeInfo][:imageLinks][:thumbnail] if book_info[:volumeInfo][:imageLinks]
  end

  def get_snippet(book_info)
    if book_info[:searchInfo] && book_info[:searchInfo][:textSnippet]
      book_info[:searchInfo][:textSnippet]
    else
      book_info[:volumeInfo][:description]
    end
  end

  def image(size = 1)
    return @image.gsub("zoom=1", "zoom=#{size}") if @image
    'https://vermontpetfood.com/media/catalog/product/cache/small_image/240x300/beff4985b56e3afdbeabfc89641a4582/placeholder/default/vermont2_1.jpg'
  end

end
