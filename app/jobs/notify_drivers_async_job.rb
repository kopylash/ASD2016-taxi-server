class NotifyDriversAsyncJob
  include SuckerPunch::Job
  def perform(order, driver_ids)
    message = {:order => order, :id_list => driver_ids, :test => "Deniskaaaaa"}
    Pusher.trigger('orders', 'new_order', message)
    # puts(message)
  end
end