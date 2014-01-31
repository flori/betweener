require 'rubygems'
require 'bundler/setup'

require 'pusher-client'
require 'serialport'
require 'rufus-scheduler'
require 'byebug'

require_relative "light_switcher"
require_relative "pusher_eater"


$scheduler = Rufus::Scheduler.new
$light_switch = LightSwitch.new
pusher = PusherEater.new("b815ed0de24f2d5ab7ea", 'site_events')

$scheduler.every("10m") do
  puts "-----"
end

$scheduler.join
loop do
  sleep(1) # Keep your main thread running
end




