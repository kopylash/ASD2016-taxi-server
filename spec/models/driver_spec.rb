require 'rails_helper'

RSpec.describe Driver, type: :model do
  it 'finds the first available driver' do
    @driver1 = FactoryGirl.create(:driver)
    @driver2 = FactoryGirl.create(:driver)
    @order = FactoryGirl.build(:order)
    expect(Driver.find_available_driver @order).to eq @driver1
  end
end
