class OrdersController < ApplicationController
  def index
    begin
      @driver = Driver.find params[:driver_id]
    rescue ActiveRecord::RecordNotFound
      render :json => {}, :status => :not_found
    else
      @orders = @driver.orders
      render :json => {:orders => @orders}
    end
  end

  def show
    begin
      @order = Order.find params[:id]
      render :json => {:order => @order}
    rescue ActiveRecord::RecordNotFound
      render :json => {}, :status => :not_found
    end
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
