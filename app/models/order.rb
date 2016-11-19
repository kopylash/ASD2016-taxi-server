class Order < ActiveRecord::Base
  belongs_to :driver
  validates_presence_of :pickup_address
  validates_presence_of :dropoff_address
  validates_presence_of :client_name
  validates_presence_of :phone
end
