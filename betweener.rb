require 'rubygems'
require 'bundler/setup'

require 'pusher-client'
require 'serialport'
require 'rufus-scheduler'
require 'byebug'

require_relative "light_switcher"
require_relative "pusher_eater"
require_relative "github_checker"


scheduler = Rufus::Scheduler.new


light_switch = LightSwitch.new("/dev/ttyACM0", scheduler)
#byebug
pusher = PusherEater.new("ec3923c4e38951e7f7c7", 'site_events', light_switch)

github_checker = GithubChecker.new("0623d1ac65f8d608c1c0412f50031388eaa070d9", 'betterplace/betterplace', light_switch, scheduler)


scheduler.every("10m") do
  puts "-----"
end

scheduler.join
loop do
  sleep(1) # Keep your main thread running
end




