class Driver < ActiveRecord::Base
  has_many :orders
  enum status: [:available, :busy, :off]

  def self.find_available_driver order
    Driver.available
  end
end
