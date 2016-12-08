class Driver < ActiveRecord::Base
  has_many :orders
  enum status: [:available, :busy, :off]
  reverse_geocoded_by :latitude, :longitude

  def self.find_available_drivers order
    self.available.near([order.pickup_lat,order.pickup_lon],10)
  end
end
