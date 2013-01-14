class Killer
  include ::BCrypt
  attr_accessor :config

  def initialize
    @config = Keep.new("config/deploy/config.yml")
  end

  def switches(reload = false)
    @switches = nil if reload
    @switches ||= installed_switches
  end

  def install(switch)
    switches = @config.get('switches')
    return true if switches && switches.include?(switch)

    @config.set(switch.to_sym, nil)
    @config.set('switches', @config.get('switches') + [switch])
    switches(true)
  end

  def uninstall(switch)
    switches = @config.get('switches')
    return false unless switches && switches.include?(switch)

    @config.delete(switch.to_sym)
    @config.set('switches', @config.get('switches') - [switch])
    switches(true)
  end

  def kill!
    @switches.map { |s| s.kill! }
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
    switch_list = @config.get('switches')
    switch_list && switch_list.map do |switch|
      (switch + "Switch").classify.constantize.new(@config.get(switch.to_sym))
    end
  end

end