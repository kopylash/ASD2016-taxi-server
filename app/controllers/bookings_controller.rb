class BookingsController < ApplicationController
  def create
    render :text => {:message => "Booking is being processed"}.to_json, :status => :created
  end
end