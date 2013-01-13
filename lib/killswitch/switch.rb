class Switch

  def config
    @config ||= Keep.new("config/#{KILLSWITCH_ENV}/config.yml")
  end

  def kill
    #kill that sumbitch
    #mechanize goes here
  end

  def name
    #override this!
    "switch"
  end

end