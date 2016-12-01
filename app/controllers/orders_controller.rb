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


  def accept
    json_params = ActionController::Parameters.new( JSON.parse(request.body.read) )
    @params = json_params.require(:accept_details).permit(:order_id, :driver_id)

    @order = Order.find_by_id(@params[:order_id])
    @driver = Driver.find_by_id(@params[:driver_id])

    if @driver.present?
      @order.driver = @driver
      @driver.status = :busy


      @order.save
      @driver.save
      render :json => {:order => @order}
      RespondToClientAsyncJob.new.async.perform(@order, @order.phone)

    else
      render :json => {}, :status => :service_unavailable
    end
  end
end
