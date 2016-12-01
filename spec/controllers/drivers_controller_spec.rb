require 'rails_helper'

RSpec.describe DriversController, type: :controller do
  describe 'GET show' do
    it 'assigns correct driver' do
      @driver = FactoryGirl.create(:driver)

      get :show, :id => @driver.id
      expect(assigns(:driver)).to eq @driver
    end
    it 'renders json' do
      @driver = FactoryGirl.create(:driver)

      get :show, :id => @driver.id
      expect(response.content_type).to eq 'application/json'
    end
    it 'returns 404 when driver doesn\'t exist' do
      get :show, :id => 1
      expect(response.status).to eq 404
    end
  end
end
