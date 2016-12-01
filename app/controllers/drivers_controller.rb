class DriversController < ApplicationController
  def show
    begin
      @driver = Driver.find(params[:id])

      render :json => {:driver => @driver}
    rescue ActiveRecord::RecordNotFound
      render :json => {}, :status => :not_found
    end
  end
end
