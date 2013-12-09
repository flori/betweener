class LightSwitch

  def initialize(serial_port, scheduler)
    @s = SerialPort.new(serial_port, baudrate: 9600)
    @scheduler = scheduler
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
      "users/sessions.create"      => [0,6,3],
      "users/registrations.create" => [6,6,3],
      "manage/needs.create"        => [6,1,3],
      "manage/blogs.create"        => [3,7,3],
      "messages.create"                    => [2,7,3],
      "bettertime/contact_messages.create" => [2,7,3],

      "collective_donations.create"=> [3,1,3],

      "donations.create"           => [3,6,3],
      "api/donations.create"       => [3,6,3],
      "iframe_donations.create"    => [3,6,3],
      "client_donations.create"    => [3,6,3],
      "mobile_donations.create"    => [3,6,3],

      "pictures.create"            => [2,2,3],
      "projects.create"            => [2,1,3],

      "manage/payouts.create"      => [4,1,3],

      "opinions.create"            => [4,6,3],
      "donation_opinions.update"   => [4,6,3],

      "comments.create"            => [6,7,3],
      "questions.create"           => [0,2,3],

      "projects.update"                                  => [0,1,3],
      "manage/project_bank_accounts.update"              => [0,1,3],
      "manage/project_carriers.update"                   => [0,1,3],
      "manage/translations/project_translations.update"  => [0,1,3],
      "manage/needs.update"                              => [0,1,3],

      "group_registrations.create"     => [6,2,3],
      "groups.update"                  => [3,2,3],
      "organisations.create"                                  => [7,7,3],
      "organisations.update"                                  => [4,7,3],
      "manage/translations/organisation_translations.update"  => [4,7,3],
      "bettertime/job_descriptions.create"                    => [4,2,3],
      "manage/blog_newsletters.create"                        => [0,7,3],

      "project_pages.show"         => [7,1,0.5],
      "groups.show"                => [3,2,0.5],
      "home.index"                 => [7,6,0.5],


    }

    # comments.create  # I think blogs, opinion
    # questions.create


#code updated => 2,6

    leds[key]
  end

  def close
    @s.close
  end

  def serial_port
    @s
  end

end