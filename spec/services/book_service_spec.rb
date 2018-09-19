require 'rails_helper'

describe BookService, type: :model do
  before(:each) do
    @service = BookService.new
  end
  it 'can find books about training a certain breed' do
    VCR.use_cassette('book-service') do
      books = @service.training_books('dog', 'boxer')
      book = books.first

      expect(books.count).to eq(10)
      expect(book).to have_key(:volumeInfo)
      expect(book[:volumeInfo]).to have_key(:title)
      expect(book[:volumeInfo]).to have_key(:authors)
      expect(book[:volumeInfo]).to have_key(:publishedDate)
      expect(book[:volumeInfo]).to have_key(:description)
      expect(book[:volumeInfo]).to have_key(:infoLink)
      expect(book[:volumeInfo]).to have_key(:imageLinks)
      expect(book[:searchInfo]).to have_key(:textSnippet)
    end
  end

  it 'can make a query string' do
    expect(@service.querify('hey you')).to eq('hey+you')
  end
end
