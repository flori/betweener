class LightSwitch

  def serial_ports
    ["/dev/ttyUSB0", "/dev/ttyUSB1", "/dev/ttyACM0"]
  end

  def initialize
    connect

    $scheduler.every("10s") do
      check_connection
    end
  end



  def connect
    serial_ports.each do |port|
      if File.exist?(port)
        @s = SerialPort.new(port, baudrate: 9600)
        puts "connected to #{port}"
      end
    end
  end

  def check_connection
    connect unless connected?  
  end


  def connected?
    if @s.nil? 
      return false
    end

    @s.write("test!\n") 
  rescue Errno::EIO
    return false
  else
    return true
  end

  def switch(controller, action)
    led = get_led_for(controller, action)
    print_debug(controller, action, led)

    blink_led(led[0], led[1], led[2]) if led
  end

  def print_debug(controller, action, led)
    unless action == "show" || action == "index"
      print "> " unless led
      puts "controller: #{controller}, action: #{action} "
    end
  end

  def blink_led(digit, led, time)
    set_led digit, led, true
    $scheduler.in time do
      set_led digit, led, false
    end
  end

  def set_led(digit, led, value)
    if @s
      val_str = value ?  "1" : "0"
      @s.write("l#{digit}#{led}#{val_str}\n")
    else 
      puts "Couldn't write to arduino port- is the dashboard plugged in?"
    end
  rescue  Errno::EIO
    puts "Couldn't write to arduino port- is the dashboard plugged in?"
  end

  def get_led_for(controller, action)
    key = controller + "." + action
    leds ={
      "users/sessions.create"      => [0,6,4],
      "users/registrations.create" => [6,6,4],
      "manage/needs.create"        => [6,1,4],
      "manage/blogs.create"        => [3,7,4],
      "messages.create"                    => [2,7,4],
      "bettertime/contact_messages.create" => [2,7,4],

      "collective_donations.create"=> [3,1,4],

      "donations.create"           => [3,6,4],
      "api/donations.create"       => [3,6,4],
      "iframe_donations.create"    => [3,6,4],
      "client_donations.create"    => [3,6,4],
      "mobile_donations.create"    => [3,6,4],

      "pictures.create"            => [2,2,4],
      "projects.create"            => [2,1,4],

      "manage/payouts.create"      => [4,1,4],

      "opinions.create"            => [4,6,4],
      "donation_opinions.update"   => [4,6,4],

      "comments.create"            => [6,7,4],
      "questions.create"           => [0,2,4],

      "projects.update"                                  => [0,1,4],
      "manage/project_bank_accounts.update"              => [0,1,4],
      "manage/project_carriers.update"                   => [0,1,4],
      "manage/translations/project_translations.update"  => [0,1,4],
      "manage/needs.update"                              => [0,1,4],
      "manage/external_donations"                        => [0,1,4],

      "group_registrations.create"     => [6,2,4],
      "groups.update"                  => [3,2,4],
      "organisations.create"                                  => [7,7,4],
      "organisations.update"                                  => [4,7,4],
      "manage/translations/organisation_translations.update"  => [4,7,4],
      "bettertime/job_descriptions.create"                    => [4,2,4],
      "manage/blog_newsletters.create"                        => [0,7,4],

      # "project_pages.show"         => [7,1,0.5],
      # "groups.show"                => [3,2,0.5],
      # "home.index"                 => [7,6,0.5],


    }

    # comments.create  # I think blogs, opinion
    # questions.create


#code updated => 2,6

    leds[key]
  end

  def test_lights
    light_switch.switch("home", "index")
    light_switch.switch("pictures","create")
  end


  def close
    @s.close
  end

  def serial_port
    @s
  end

end