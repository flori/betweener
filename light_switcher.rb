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
      # "users/sessions.create"      => [0,0,3],
      # "users/registrations.create" => [0,4,3],
      # "manage/needs.create"        => [0,5,3],

      # "donations.create"           => [1,0,3],
      # "api/donations.create"       => [1,0,3],
      # "iframe_donations.create"    => [1,0,3],
      # "client_donations.create"    => [1,0,3],
      # "mobile_donations.create"    => [1,0,3],

      # "pictures.create"            => [1,4,3],
      # "projects.create"            => [1,5,3],

      # "manage/payouts.create"      => [2,0,3],

      # "project_pages.update"       => [2,4,3],
      # "manage/project_bank_accounts.update"              => [2,4,3],
      # "manage/project_carriers.update"                   => [2,4,3],
      # "manage/translations/project_translations.update"  => [2,4,3],
      # "manage/needs.update"                              => [2,4,3],


      "users/sessions.create"      => [7,1,3],
      "users/registrations.create" => [7,4,3],
      "manage/needs.create"        => [7,5,3],
      "users/registrations.create" => [7,2,3],
      "manage/blogs.create"        => [7,3,3],
      "messages.create"                    => [7,6,3],
      "bettertime/contact_messages.create" => [7,6,3],

      "collective_donations.create"=> [7,7,3],

      "donations.create"           => [6,1,3],
      "api/donations.create"       => [6,1,3],
      "iframe_donations.create"    => [6,1,3],
      "client_donations.create"    => [6,1,3],
      "mobile_donations.create"    => [6,1,3],

      "pictures.create"            => [6,2,3],
      "projects.create"            => [6,3,3],

      "manage/payouts.create"      => [6,4,3],

      "opinions.create"            => [6,5,3],
      "donation_opinions.update"   => [6,5,3],

      "projects.update"       => [6,6,3],
      "manage/project_bank_accounts.update"              => [6,6,3],
      "manage/project_carriers.update"                   => [6,6,3],
      "manage/translations/project_translations.update"  => [6,6,3],
      "manage/needs.update"                              => [6,6,3],

      "group_registrations.create"     => [7,1,3],
      "groups.update"                  => [7,2,3],
      "organisations.create"                                  => [7,3,3],
      "organisations.update"                                  => [7,4,3],
      "manage/translations/organisation_translations.update"  => [7,5,3],
      "bettertime/job_descriptions.create"                    => [7,6,3],
      "manage/blog_newsletters.create"                        => [7,7,3],

      "project_pages.show"         => [1,4,0.5],
      "groups.show"                => [0,4,0.5],
      "home.index"                 => [0,0,0.5],
    }

    # donation_comments.create
    # comments.create  # I think blogs, opinion
    # questions.create


    leds[key]
  end

  def close
    @s.close
  end

  def serial_port
    @s
  end

end