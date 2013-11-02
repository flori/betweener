require 'rubygems'
require 'pusher-client'
require 'serialport'
require 'rufus-scheduler'
require_relative "light_switcher"
require_relative "pusher_eater"

light_switch = LightSwitch.new("/dev/ttyACM0")

light_switch.blink_light(1)
light_switch.blink_light(6)
pusher = PusherEater.new("ec3923c4e38951e7f7c7", 'site_events', light_switch)



#scheduler = Rufus::Scheduler.new

#scheduler.every '5s' do
#  light_switch.blink_light(7)
#end

#scheduler.join

loop do
  sleep(1) # Keep your main thread running
end




