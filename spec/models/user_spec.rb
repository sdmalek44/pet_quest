require 'rails_helper'

describe User, type: :model do
  context 'has relationships' do
    it {should have_many :favorites}
  end
end
