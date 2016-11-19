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
      post :create, :order => FactoryGirl.build(:order).to_json
      expect(assigns(:order).class).to eq Order
    end
    it 'returns error code when invalid data provided' do
      post :create, :order => FactoryGirl.build(:invalid_order).to_json
      expect(response.status).to eq 400
    end
    it 'assigns available driver' do
      @driver = FactoryGirl.create(:driver)
      post :create, :order => FactoryGirl.build(:order).to_json
      expect(assigns(:order).driver).to eq @driver
    end
    it 'throws error when no available drivers found' do
      post :create, :order => FactoryGirl.build(:order).to_json
      expect(response.status).to eq 503
    end
  end
end
