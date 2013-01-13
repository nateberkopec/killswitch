class Killer
  include ::BCrypt

  def config
    @config ||= Keep.new('config/config.yml')
  end

  def switches
    #list installed switches
  end

  def kill
    #kill all switches
  end

  def password
    @password ||= Password.new(config.get(:password_hash))
  end

  def password=(new_password)
    @password = Password.create(new_password)
    config.set(:password_hash, @password)
  end

end