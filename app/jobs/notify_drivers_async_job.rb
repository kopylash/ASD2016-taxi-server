class NotifyDriversAsyncJob
  include SuckerPunch::Job
  def perform(order, driver_ids)
    message = {:order => order, :id_list => driver_ids}
    Pusher.trigger('orders', 'new_order', message)
  end
end