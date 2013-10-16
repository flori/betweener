require 'rubygems'
require 'pusher-client'
require 'serialport'
require_relative "light_switcher"

light_switch = LightSwitch.new("/dev/ttyACM0")

PusherClient.logger = Logger.new('/dev/null')
socket = PusherClient::Socket.new("ec3923c4e38951e7f7c7")
socket.connect(true) # Connect asynchronously

socket.subscribe('site_events')

def get_param_from_message(message, param)
  message.split(" ").find{|e| e.include?("#{param}=") }.split("=").last
end


socket.bind('event') do |data|
  #puts data
  
  controller = get_param_from_message(data, "controller")
  action     = get_param_from_message(data, "action")

  puts "controller: #{controller}, action: #{action} "

  light_switch.switch(controller, action)
end

loop do
  sleep(1) # Keep your main thread running
end




