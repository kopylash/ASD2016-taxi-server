class Driver < ActiveRecord::Base
  has_many :orders
  enum status: [:available, :busy, :off]
end
