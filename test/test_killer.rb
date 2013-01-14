require 'minitest/autorun'
require './lib/killswitch'
require './bin/killswitch'
require 'pry'

class TestKillswitch < MiniTest::Unit::TestCase

  def setup
    @app = Killer.new
    @path = '/tmp/test'
    @app.config = Keep.new(@path)
    config_fixtures.each { |k, v| @app.config.set(k, v) }
  end

  def teardown
    `rm -rf #{@path}`
  end

  def test_config_settings
    @app.config.set('nuclear_launch_codes', '12345')

    assert_equal '12345', @app.config.get('nuclear_launch_codes')
  end

  def test_password_setting
    @app.password = '12345'

    assert @app.password == '12345'
    refute @app.config.get('password_hash').to_s == "12345" #it isnt plaintext
  end

  def test_switches
    assert_equal 2, @app.switches.length
    assert_equal FacebookSwitch, @app.switches.first.class
    assert_equal ['twitter', 'facebook'], @app.available_switches
  end

  def test_kill
    @app.config.set(:switches, ['facebook'])

    @app.switches.first.stub :kill!, true do
      assert @app.kill! == [true]
    end
  end

  def test_uninstall
    @app.uninstall('twitter')

    assert_equal ['facebook'], @app.switches.map {|s| s.name}
  end

  def test_uninstall_fail
    refute @app.uninstall('myspace')
  end

  def test_install
    @app.uninstall('twitter')
    assert_equal ['facebook'], @app.switches.map {|s| s.name}

    @app.install('twitter')
    assert_equal ['facebook', 'twitter'], @app.switches.map {|s| s.name}
  end

  def test_install_fail
    refute @app.install('myspace')
  end

  private

  def config_fixtures
    { :facebook => {
        :username => 'billy@droptables.com',
        :password_hash => BCrypt::Password.create('12345').to_s,
        :killmode => 'password'
      },
      :twitter => {
        :username => 'billy@droptables.com',
        :password_hash => BCrypt::Password.create('12345').to_s,
        :killmode => 'password'
      },
      :switches => ['facebook', 'twitter']
    }
  end
end