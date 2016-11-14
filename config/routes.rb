Rails.application.routes.draw do
  post "/bookings", :to => "bookings#create"
end
