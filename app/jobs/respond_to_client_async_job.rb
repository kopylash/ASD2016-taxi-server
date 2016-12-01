class RespondToClientAsyncJob
  include SuckerPunch::Job
  def perform(order, client_number)
    message = {:order => order}
    Pusher.trigger(client_number, "order_accepted", message)
    puts(message)
  end
end