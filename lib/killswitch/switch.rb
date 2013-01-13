class Switch

  def config
    @config ||= Keep.new("config/#{KILLSWITCH_ENV}/config.yml")
  end

  def kill!
    #kill that sumbitch
    #mechanize goes here
    raise "The author of this switch did not redefine this method"
  end

  def name
    raise "The author of this switch did not redefine this method"
  end

end