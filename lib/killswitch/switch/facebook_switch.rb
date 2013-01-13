class FacebookSwitch < Switch

  def initialize(config)
    @killmode = config.fetch(:killmode)
    @username = config.fetch(:username)
    @password = config.fetch(:password)
  end

  def kill!
    if @killmode == "password_reset"
      "reset"
    elsif @killmode == "destroy"
      "destroyed"
    else
      raise "Invalid option for #{name} killmode"
    end
  end

  def name
    "facebook"
  end

end