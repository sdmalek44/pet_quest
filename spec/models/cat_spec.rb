require 'rails_helper'

describe Cat, type: :model do
  it 'it can get breeds' do
    param_info = {status: {}, age: {}, name: {},
                  sex: {}, size: {}, media: {},
                  id: {}, breeds: {breed: [{:$t => 'canadian'}]}, description: {},
                  last_update: {}, shelter_id: {}}
    cat = Cat.new(param_info)

    expect(cat.get_breeds(param_info[:breeds][:breed])).to eq(['canadian'])
  end
end
