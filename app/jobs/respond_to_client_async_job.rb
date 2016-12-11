class RespondToClientAsyncJob
  include SuckerPunch::Job
  def perform(order, driver, client_number)
    message = {:order => order, :driver => driver}
    Pusher.trigger(client_number, "order_accepted", message)
  end
end