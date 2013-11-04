class LightSwitch

  def initialize(serial_port, scheduler)
    @s = SerialPort.new(serial_port, baudrate: 9600)
    @scheduler = scheduler
  end

  def switch(controller, action)   
    led = get_led_for(controller, action)
    blink_led(led[0], led[1], led[2]) if led
  end

  def blink_led(digit, led, time)
    set_led digit, led, true
    @scheduler.in time do
      set_led digit, led, false
    end
  end

  def set_led(digit, led, value)
    val_str = value ?  "1" : "0"
    @s.write("l#{digit}#{led}#{val_str}\n")
  end

  def get_led_for(controller, action)
    key = controller + "." + action
    leds ={
      "manage/blogs.create"        => [0,0,2],
      "home.index"                 => [0,4,0.5],
      "manage/elements.create"     => [0,5,2],
      "donations.create"           => [1,0,2],
      "pictures.create"            => [1,4,2],
      "projects.create"            => [1,5,2],
      "project_pages.show"         => [2,0,0.5],
      "project_pages.update"       => [2,4,2],
      "manage/project_bank_accounts.update"              => [2,4,2],
      "manage/project_carriers.update"                   => [2,4,2],
      "manage/translations/project_translations.update"  => [2,4,2],
      #"manage/payouts.create"             => [2,4],
      #"users/registrations.create" => [2,5],
    }

    # ["users/registrations",     "create"]
    # ["users/sessions",          "create"]
    # ["messages",     "create"]   
    # ["manage/blog_newsletters",     "create"]
    # ["organisations",     "update"]
    # users/sessions, action: create
    # "iframe_donations.create"

    # project updated:
    # manage/translations/project_translations, action: update
    # ["projects",     "update"]
    # manage/project_bank_accounts, update
    # manage/project_carriers, action: update
    leds[key]
  end

  def close
    @s.close
  end

  def serial_port
    @s
  end

end