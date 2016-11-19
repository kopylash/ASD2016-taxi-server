require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe 'GET index' do
    before :all do
      @driver1 = Driver.create!(:name => 'Driver 1')
      @driver2 = Driver.create!(:name => 'Driver 2')
      @order1 = Order.create!(:client_name => 'Client 1')
      @order2 = Order.create!(:client_name => 'Client 2')
      @order1.driver = @driver1
      @order2.driver = @driver2
      @order1.save!
      @order2.save!
    end
    it 'returns orders of the given driver' do
      get :index, :driver_id => @driver1.id
      expect(assigns(:orders)).to include @order1
    end
    it 'does not return orders of other drivers' do
      get :index, :driver_id => @driver1.id
      expect(assigns(:orders)).not_to include @order2
    end
    it 'returns json' do
      get :index, :driver_id => @driver1.id
      expect(response.content_type).to eq 'application/json'
    end
  end

  describe 'GET show' do
    before :all do
      @order = Order.create!(:client_name => 'Client 1')
    end
    it 'assigns correct order' do
      get :show, :id => @order.id
      expect(assigns(:order)).to eq @order
    end
    it 'returns json' do
      get :show, :id => @order.id
      expect(response.content_type).to eq 'application/json'
    end
  end
end
