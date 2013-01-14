class FacebookSwitch < Switch

  attr_accessor :killmode, :username, :password

  def initialize(config)
    config = {} if config.nil?
    @killmode = config[:killmode]
    @username = config[:username]
    @password = config[:password_hash] && BCrypt::Password.new(config[:password_hash])
    @agent = Mechanize.new { |agent| agent.user_agent_alias = 'Mac Safari' }
  end

  def kill!
    if @killmode == "password_reset"
      @agent.get('http://facebook.com/') do |page|
        login_result = page.form_with(:action => "https://www.facebook.com/login.php?login_attempt=1") do |login|
          login.email = @username
          login.pass = @password
        end.submit

        settings_page = @agent.get("https://www.facebook.com/settings?ref=mb")
        
        #reset the pw
      end
    elsif @killmode == "destroy"
      "destroyed"
    else
      raise "Invalid option for #{name} killmode"
    end
  end

  def self.name
    "facebook"
  end

end