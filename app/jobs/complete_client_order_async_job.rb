class CompleteClientOrderAsyncJob
  include SuckerPunch::Job
  def perform(client_number)
    message = {:completed => true}
    puts "complete order: " + message.to_s
    Pusher.trigger(client_number, "order_completed", message)
  end
end