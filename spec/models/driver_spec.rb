require 'rails_helper'

RSpec.describe Driver, type: :model do
  it 'finds drivers within 10km of order pickup point' do
    @driver = FactoryGirl.create(:driver)
    @driver.latitude = 58.3839796
    @driver.longitude = 26.7392654
    @driver.save!
    @order = FactoryGirl.build(:order)
    expect(Driver.find_available_drivers @order).to include @driver
  end
  it 'does not return drivers further than 10km from order pickup point' do
    @driver = FactoryGirl.create(:driver)
    @driver.latitude = 59.4377625
    @driver.longitude = 24.7461969
    @driver.save!
    @order = FactoryGirl.build(:order)
    expect(Driver.find_available_drivers @order).to_not include @driver
  end
end
