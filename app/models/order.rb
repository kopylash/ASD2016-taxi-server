class Order < ActiveRecord::Base
  belongs_to :driver
  validates_presence_of :pickup_address
  validates_presence_of :dropoff_address
  validates_presence_of :client_name
  validates_presence_of :phone

  before_create do
    assign_driver
  end

  def assign_driver
    self.driver = Driver.available.first
  end
end
