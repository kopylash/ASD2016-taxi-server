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

  def create
    order_params = JSON.parse params[:order]

    @order = Order.new order_params

    if @order.save
      render :json => {:order => @order}
    else
      render :json => {:errors => @order.errors}, :status => :bad_request
    end
  end
end
