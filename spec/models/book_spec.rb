require 'rails_helper'

describe Book, type: :model do
  before(:each) do

    @book_info = {volumeInfo:
                {title: 'bob', authors: 'bob', publishedDate: '2018-3-2',
                description: 'bob', infoLink: 'link'}
              }
    @book = Book.new(@book_info)
  end
  it 'has attributes' do
    expect(@book.title).to eq('bob')
    expect(@book.authors).to eq('bob')
    expect(@book.date).to eq('2018-3-2')
    expect(@book.link).to eq('link')
    expect(@book.description).to eq('bob')
    expect(@book.snippet).to eq('bob')
    expect(@book.image).to eq('https://vermontpetfood.com/media/catalog/product/cache/small_image/240x300/beff4985b56e3afdbeabfc89641a4582/placeholder/default/vermont2_1.jpg')
  end
end
