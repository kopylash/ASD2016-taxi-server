require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'assigns drivers' do
    it 'assigns an available driver' do
      @free_driver = FactoryGirl.create(:driver)
      @free_driver.status = :available
      @free_driver.save!
      @order = FactoryGirl.create(:order)

      expect(@order.driver).to eq @free_driver
    end
  end
end
