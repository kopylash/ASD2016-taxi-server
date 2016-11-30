class OrdersController < ApplicationController

   def valid_params
     json_params = ActionController::Parameters.new( JSON.parse(request.body.read) )
     json_params.require(:order).permit(:pickup_address, :dropoff_address, :client_name, :phone)
   end

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
    @order = Order.new valid_params

    if @order.valid?

      available_driver = Driver.find_available_drivers @order
      # TODO notify drivers

        @order.save

        render :json => {:order => @order}
   else
      render :json => {:errors => @order.errors}, :status => :bad_request
    end
  end
end
