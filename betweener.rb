require 'rubygems'
require 'bundler/setup'

require 'pusher-client'
require 'serialport'
require 'rufus-scheduler'
require 'byebug'

require_relative "light_switcher"
require_relative "pusher_eater"
require_relative "github_checker"


$scheduler = Rufus::Scheduler.new
$light_switch = LightSwitch.new
pusher = PusherEater.new("b815ed0de24f2d5ab7ea", 'site_events')

#byebug


#github_checker = GithubChecker.new("0623d1ac65f8d608c1c0412f50031388eaa070d9", 'betterplace/betterplace', light_switch, scheduler)


$scheduler.every("10m") do
  puts "-----"
end

$scheduler.join
loop do
  sleep(1) # Keep your main thread running
end




