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

  def switches_names
    switches.map { |k, _| k.to_s }
  end

  def available_switches
    Switch.subclasses.map { |s| s.name }
  end

  def install(switch)
    return true if switches && switches[switch.to_sym]
    return false unless available_switches.include?(switch)

    @config.set(switch.to_sym, nil)
    @config.set('switches', @config.get('switches') + [switch])
    switches(true)
  end

  def uninstall(switch)
    return false unless switches && switches[switch.to_sym]

    @config.delete(switch.to_sym)
    @config.set('switches', @config.get('switches') - [switch])
    switches(true)
  end

  def kill!
    @switches.map { |k, v| v.kill! }
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
    if switch_list
      switches = {}
      switch_list.each do |switch|
        switches[switch.to_sym] = (switch + "Switch").classify.constantize.new(@config.get(switch.to_sym))
      end
      switches
    else
      {}
    end
  end

end