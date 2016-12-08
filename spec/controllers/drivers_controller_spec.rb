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

RSpec.describe "PUT update", :type => :request do
  it 'returns error if no driver is found' do
    put driver_path(1)

    expect(response.status).to eq 404
  end
  it 'updates driver status' do
    @driver = FactoryGirl.create(:driver)
    @driver.status = :available
    @driver.save!

    put driver_path(@driver.id), {driver: {status: 'busy'}}.to_json
    expect(assigns(:driver).status).to eq 'busy'
  end
  it 'returns error when wrong status given' do
    @driver = FactoryGirl.create(:driver)

    put driver_path(@driver.id), {driver: {status: 'flying'}}.to_json

    expect(response.status).to eq 400
  end
  it 'sets new coordinates' do
    @driver = FactoryGirl.create(:driver)

    put driver_path(@driver.id), {driver: { latitude: 40.6892494, longitude: -74.044500}}.to_json

    expect(assigns(:driver).latitude).to eq 40.6892494
    expect(assigns(:driver).longitude).to eq -74.044500
  end
end
