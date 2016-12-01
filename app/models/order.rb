class Order < ActiveRecord::Base
  belongs_to :driver
  validates_presence_of :pickup_address
  validates_presence_of :dropoff_address
  validates_presence_of :client_name
  validates_presence_of :phone

  def self.calculate_price distance_m
    km_price = 0.69 # price, in euros, per kilometer

    distance_m / 1000 * km_price
  end

  def self.trip_data pickup, dropoff
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
