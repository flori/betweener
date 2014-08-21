require 'rubygems'
require 'bundler/setup'

require 'pusher-client'
require 'serialport'
require 'rufus-scheduler'
require 'byebug'

require_relative "light_switcher"
require_relative "pusher_eater"
require_relative "config"


$scheduler = Rufus::Scheduler.new
$light_switch = LightSwitch.new
pusher = PusherEater.new($pusher_key, 'page-hits-production')

$scheduler.every("10m") do
  puts "-----"
end

$scheduler.join
loop do
  sleep(1) # Keep your main thread running
end




