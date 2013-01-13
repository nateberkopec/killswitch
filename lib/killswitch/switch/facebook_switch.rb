class FacebookSwitch < Switch

  def initialize(config)
    @killmode = config.fetch(:killmode)
    @username = config.fetch(:username)
    @password = config.fetch(:password)
  end

  def kill!
    #do some mechanize
  end

  def name
    "facebook"
  end

end