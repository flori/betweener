require 'rubygems'
require 'serialport'
require_relative "light_switcher"

light_switch = LightSwitch.new




(0..8).each do |x|
  (0..8).each do |y|
    light_switch.set_led(x, y, true)
  end
end
sleep 5

(0..8).each do |x|
  (0..8).each do |y|
    light_switch.set_led(x, y, false)
  end
end




light_switch.led_matrix.each do |action, led|
  light_switch.set_led(led[0], led[1], true)
  sleep(0.5)
  light_switch.set_led(led[0], led[1], false)
end

light_switch.close