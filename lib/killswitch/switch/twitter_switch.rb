class TwitterSwitch < Switch

  def initialize(config)
    config = {} if config.nil?
    @killmode = config[:killmode]
    @username = config[:username]
    @password = config[:password_hash] && BCrypt::Password.new(config[:password_hash])
  end

  def kill!
    if @killmode == "password_reset"
      "reset"
    elsif @killmode == "destroy"
      "destroyed"
    elsif @killmode == "destroy_and_mangle"
      "destroyed and mangled"
    else
      raise "Invalid option for #{name} killmode"
    end
  end

  def self.name
    "twitter"
  end

end