class Killer
  include ::BCrypt
  attr_writer :config

  def config
    @config ||= Keep.new("config/deploy/config.yml")
  end

  def switches
    @switches ||= installed_switches
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

  private

  def installed_switches
    switch_list = @config.get('switches').split(', ')
    switch_list.map do |switch|
      (switch + "Switch").classify.constantize.new(@config.get(switch))
    end
  end

end