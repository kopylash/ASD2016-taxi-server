class DriversController < ApplicationController
  def valid_params
    json_params = ActionController::Parameters.new(JSON.parse(request.body.read))
    return json_params.require(:driver).permit(:latitude, :longitude, :status)
  end

  def show
    begin
      @driver = Driver.find(params[:id])

      render :json => {:driver => @driver}
    rescue ActiveRecord::RecordNotFound
      render :json => {}, :status => :not_found
    end
  end

  def update
    begin
      @driver = Driver.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render :json => {}, :status => :not_found
    else
      params = valid_params

      @driver.latitude = params["latitude"] if params["latitude"]

      @driver.longitude = params["longitude"] if params["longitude"]

      begin
        @driver.status = params["status"] if params["status"]
      rescue ArgumentError
        render :json => {}, :status => :bad_request
      else
        @driver.save

        render :json => { :driver => @driver }
      end
    end
  end
end
