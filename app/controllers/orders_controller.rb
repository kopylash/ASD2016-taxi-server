class OrdersController < ApplicationController
  def index
    @driver = Driver.find(params[:driver_id])
    @orders = @driver.orders
    render :json => @orders.to_json
  end
end
