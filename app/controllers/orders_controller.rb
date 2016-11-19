class OrdersController < ApplicationController
  def index
    @driver = Driver.find params[:driver_id]
    @orders = @driver.orders
    render :json => {:orders => @orders}
  end

  def show
    @order = Order.find params[:id]
    render :json => {:order => @order}
  end
end
