require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe 'GET index' do
    it 'returns orders of the given driver' do
      @driver1 = FactoryGirl.create(:driver)
      @order1 = FactoryGirl.create(:order)
      @order1.driver = @driver1
      @order1.save!

      get :index, :driver_id => @driver1.id
      expect(assigns(:orders)).to include @order1
    end
    it 'does not return orders of other drivers' do
      @driver1 = FactoryGirl.create(:driver)
      @order1 = FactoryGirl.create(:order)
      @order1.driver = @driver1
      @order1.save!
      @driver2 = FactoryGirl.create(:driver)
      @order2 = FactoryGirl.create(:order)
      @order2.driver = @driver2
      @order2.save!

      get :index, :driver_id => @driver1.id
      expect(assigns(:orders)).not_to include @order2
    end
    it 'returns json' do
      @driver1 = FactoryGirl.create(:driver)

      get :index, :driver_id => @driver1.id
      expect(response.content_type).to eq 'application/json'
    end
    it 'returns 404 if invalid driver id given' do
      get :index, :driver_id => 1
      expect(response.status).to eq 404
    end
  end

  describe 'GET show' do
    it 'assigns correct order' do
      @order = FactoryGirl.create(:order)

      get :show, :id => @order.id
      expect(assigns(:order)).to eq @order
    end
    it 'returns json' do
      @order = FactoryGirl.create(:order)

      get :show, :id => @order.id
      expect(response.content_type).to eq 'application/json'
    end
    it 'returns 404 if invalid order id given' do
      get :show, :id => 1
      expect(response.status).to eq 404
    end
  end

  describe 'POST create' do
    it 'creates new order' do
      post :create, {:order => FactoryGirl.build(:order)}.to_json
      expect(assigns(:order).class).to eq Order
    end
    it 'returns error code when invalid data provided' do
      post :create, {:order => FactoryGirl.build(:invalid_order)}.to_json
      expect(response.status).to eq 400
    end
  end
end

RSpec.describe "Orders accept", :type => :request do
  it 'returns 404 status code if no driver in req' do
    @order = FactoryGirl.create(:order)
    params = {accept_details: {order_id: @order.id}}

    post accept_orders_path, params.to_json, {format: :json}
    expect(response.status).to eq 404
  end

  it 'returns 404 status code if no order in req' do
    @driver = FactoryGirl.create(:driver)
    params = {accept_details: {driver_id: @driver.id}}

    post accept_orders_path, params.to_json, {format: :json}
    expect(response.status).to eq 404
  end

  it 'assigns driver' do
    @driver = FactoryGirl.create(:driver)
    @order = FactoryGirl.create(:order)
    params = {accept_details: {driver_id: @driver.id, order_id: @order.id}}

    post accept_orders_path, params.to_json, {format: :json}
    expect(assigns(:order).driver).to eq @driver
  end

  it 'assigns driver status to busy' do
    @driver = FactoryGirl.create(:driver)
    @order = FactoryGirl.create(:order)
    params = {accept_details: {driver_id: @driver.id, order_id: @order.id}}

    post accept_orders_path, params.to_json, {format: :json}
    expect(assigns(:driver).status).to eq "busy"
  end

  # todo check pusher call

end

RSpec.describe "Complete order", :type => :request do
  it 'returns 404 status code if no order found' do
    post complete_order_path(87)
    expect(response.status).to eq 404
  end

  it 'sets complete status to the order' do
    @order = FactoryGirl.create(:order)

    post complete_order_path(@order.id)
    expect(assigns(:order).completed).to eq true
  end

  it 'returns 200 OK' do
    @order = FactoryGirl.create(:order)

    post complete_order_path(@order.id)
    expect(response.status).to eq 200
  end

end
