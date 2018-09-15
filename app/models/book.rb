class Book
  attr_reader :title,
              :authors,
              :date,
              :link,
              :description

  def initialize(book_info)
    @title = book_info[:volumeInfo][:title]
    @authors = book_info[:volumeInfo][:authors]
    @date = book_info[:volumeInfo][:publishedDate]
    @description = book_info[:volumeInfo][:description]
    @link = book_info[:volumeInfo][:infoLink]
    @image = book_info[:volumeInfo][:imageLinks][:thumbnail] if book_info[:volumeInfo][:imageLinks]
  end

  def snippet
    @description[0..285] + '...'
  end


  def image(size = 1)
    return @image.gsub("zoom=1", "zoom=#{size}") if @image
    'https://vermontpetfood.com/media/catalog/product/cache/small_image/240x300/beff4985b56e3afdbeabfc89641a4582/placeholder/default/vermont2_1.jpg'
  end

end
