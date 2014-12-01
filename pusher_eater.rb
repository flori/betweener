require 'logger'
require 'json'

class PusherEater

  def initialize(app_id, channel)
    @app_id = app_id
    @channel = channel

    PusherClient.logger = Logger.new('/dev/null')
    connect
  end

  def connect
    @socket = PusherClient::Socket.new(@app_id)
    @socket.connect(true) # Connect asynchronously
    @socket.subscribe(@channel)

    @socket.bind('page_hit') do |data|

      json = JSON.parse(data)

      # puts json["controller"]
      # puts json["action"]

      $light_switch.switch(json["controller"], json["action"])
    end
  end

  def reconnect
    puts "reconnecting to pusher to keep alive"
    @socket.disconnect
    connect
  end
end
