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

      available_drivers = Driver.find_available_drivers @order
      NotifyDriversAsyncJob.new.async.perform(@order,  available_drivers.map  { |p| p.id })

      @order.save

      render :json => {:order => @order}
      # todo maybe just send "order being processeed"
      else
      render :json => {:errors => @order.errors}, :status => :bad_request
    end
  end


  def accept_order
    # if available_drivers.present?
    #   @order.driver = available_drivers
    #
    #   available_drivers.status = :busy
    #   available_drivers.save
    #
    #   @order.save
    #
    #   render :json => {:order => @order}
    # else
    #   render :json => {}, :status => :service_unavailable
    # end
    # #todo send info to client (order + driver info)
  end
end
