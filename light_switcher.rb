class LightSwitch

  def initialize(serial_port)
    @s = SerialPort.new(serial_port, baudrate: 9600)
  end

  def switch(controller, action)
    light = get_light_for(controller, action)
    if light
      string = make_number_string_for_light(light)
      @s.write(string)
      sleep(0.5)
      @s.write("xxxxxxxx\r\n")
    end
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
       
    ]
    lights.index [controller, action]
  end

  def make_number_string_for_light(index)
    str = "xxxxxxxx\r\n"
    str[index] = "8"
    str
  end

end