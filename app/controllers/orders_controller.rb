class OrdersController < ApplicationController

  def valid_params
    json_params = ActionController::Parameters.new(JSON.parse(request.body.read))
    return json_params.require(:order).permit(:pickup_address, :dropoff_address, :client_name, :phone, :pickup_lat, :pickup_lon, :dropoff_lat, :dropoff_lon, :price)
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

      unless @order.price.present?
        matrix_data = get_trip_data @order.pickup_address, @order.dropoff_address

        price = calculate_price matrix_data.distance_in_meters

        @order.price = price
      end

      @order.save

      render :json => {:order => @order}
    else
      render :json => {:errors => @order.errors}, :status => :bad_request
    end
  end

  def price
    matrix_data = get_trip_data params[:pickup], params[:dropoff]

    distance = matrix_data.distance_in_meters

    price_estimate = calculate_price distance

    render :json => {
      :distance => distance,
      :price => price_estimate
    }
  end

  def calculate_price distance_m
    km_price = 0.69 # price, in euros, per kilometer

    distance_m / 1000 * km_price
  end

  def get_trip_data pickup, dropoff
    origin = {
      address: pickup
    }

    destination = {
      address: dropoff
    }

    matrix = GoogleDistanceMatrix::Matrix.new

    matrix.origins << origin
    matrix.destinations << destination

    matrix_data = matrix.data

    matrix_data[0][0]
  end
end
