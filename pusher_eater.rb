require 'logger'

class PusherEater

  def initialize(app_id, channel)
    @app_id = app_id
    @channel = channel

    PusherClient.logger = Logger.new('/dev/null')
    connect
  end

  def get_param_from_message(message, param)
    message.split(" ").find{|e| e.include?("#{param}=") }.split("=").last
  end

  def connect
    @socket = PusherClient::Socket.new(@app_id)
    @socket.connect(true) # Connect asynchronously
    @socket.subscribe(@channel)

    @socket.bind('event') do |data|

      controller = get_param_from_message(data, "controller")
      action     = get_param_from_message(data, "action")

      $light_switch.switch(controller, action)
    end
  end

  def reconnect
    puts "reconnecting to pusher to keep alive"
    @socket.disconnect
    connect
  end


end