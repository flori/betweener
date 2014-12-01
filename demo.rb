require 'rubygems'
require 'serialport'
require 'rufus-scheduler'
require_relative "light_switcher"

light_switch = LightSwitch.new
light_switch.switch_all_off


$scheduler = Rufus::Scheduler.new

leds = [
  [0,6],
  [6,6],
  [6,1],
  [3,7],
  [2,7],
  [3,1],
  [3,6],
  [2,2],
  [2,1],
  [4,1],
  [4,6],
  [2,6],
  [0,2],
  [0,1],
  [6,2],
  [7,2],
  [7,7],
  [4,7],
  [4,2],
  [0,7]
]


$scheduler.every("1s") do
  time = rand(3)
  $scheduler.in("#{time}s") do
    led = leds.sample
    light_switch.blink_led(led[0], led[1], 2)
  end
end

$scheduler.join
loop do
  sleep(1) # Keep your main thread running
end

light_switch.close
