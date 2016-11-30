# config/initializers/pusher.rb
require 'pusher'

Pusher.app_id = '270293'
Pusher.key = '49d687ce69d0caf32b29'
Pusher.secret = '29aa4b6a044267c01c03'
Pusher.logger = Rails.logger
Pusher.encrypted = true