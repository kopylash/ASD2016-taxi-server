class CompleteClientOrderAsyncJob
  include SuckerPunch::Job
  def perform(client_number)
    message = {:completed => true}
    Pusher.trigger(client_number, "order_completed", message)
  end
end