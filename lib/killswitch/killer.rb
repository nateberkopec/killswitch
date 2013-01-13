class Killer

  def config
    @config ||= Keep.new('config/config.yml')
  end

  def switches
    #list installed switches
  end

  def kill
    #kill all switches
  end

end