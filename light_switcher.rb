class LightSwitch

  def initialize(serial_port)
    @s = SerialPort.new(serial_port, baudrate: 9600)
  end

  def switch(controller, action)   
    led = get_led_for(controller, action)
    blink_led(led.first, led.last) if led
  end

  def blink_led(digit, led)
    @s.write("l#{digit}#{led}1\n")
    sleep(0.5)
    @s.write("l#{digit}#{led}0\n")
  end

  def get_led_for(controller, action)
    key = controller + "." + action
    leds ={
      "manage/blogs.create"        => [0,0],
      "home.index"                 => [0,4],
      "donations.create"           => [0,5],
      "manage/elements.create"     => [1,0],
      "pictures.create"            => [1,4],
      "projects.create"            => [1,5],
      "iframe_donations.create"    => [2,0],
      "payouts.create"             => [2,4],
      "users/registrations.create" => [2,5],
    }

    # ["users/registrations",     "create"]
    # ["users/sessions",          "create"]
    # ["messages",     "create"]   
    # ["manage/blog_newsletters",     "create"]
    # ["organisations",     "update"]
    # ["projects",     "update"]
    leds[key]
  end

  def close
    @s.close
  end

  def serial_port
    @s
  end

end