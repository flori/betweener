class LightSwitch

  def initialize(serial_port)
    @s = SerialPort.new(serial_port, baudrate: 9600)
  end

  def switch(controller, action)
    light = get_light_for(controller, action)
    blink_light(light) if light
  end

  def blink_light(light)
    @s.write("d#{light}8\n")
    sleep(0.5)
    @s.write("d#{light}x\n")
  end

  def get_light_for(controller, action)
    lights = [
      ["home",             "index"],
      ["donations",        "create"],
      ["iframe_donations", "create"],
      ["manage/elements",  "create"],
      ["projects",         "create"],
      ["pictures",         "create"],
      ["payouts",          "create"],
      ["manage/blogs",     "create"]

      # ["users/registrations",     "create"]
      # ["users/sessions",          "create"]
      # ["messages",     "create"]   
      # ["manage/blog_newsletters",     "create"]
      # ["organisations",     "update"]
      # ["projects",     "update"]
       
    ]
    lights.index [controller, action]
  end

  def close
    @s.close
  end

  def serial_port
    @s
  end

end