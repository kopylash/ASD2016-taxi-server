class RespondToClientAsyncJob
  include SuckerPunch::Job
  def perform(order, driver, client_number, travel_time)
    message = {:order => order, :driver => driver, :travelTime => travel_time}
    puts "respond to client: " + message.to_s
    Pusher.trigger(client_number, "order_accepted", message)
  end
end