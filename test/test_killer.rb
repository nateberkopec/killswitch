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
    @app.password = '12345'
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
    assert_equal FacebookSwitch, @app.switches.first[1].class
    assert_equal ["twitter", "facebook"], @app.available_switches
  end

  def test_kill
    @app.config.set(:switches, ['facebook'])

    @app.switches.first[1].stub :kill!, true do
      assert @app.kill!('12345') == [true]
      assert @app.kill!('wrong_pass') == [false]
    end
  end

  def test_uninstall
    @app.uninstall('twitter')

    assert_equal ['facebook'], @app.switches_names
  end

  def test_uninstall_fail
    refute @app.uninstall('myspace')
  end

  def test_install
    @app.uninstall('twitter')
    assert_equal ['facebook'], @app.switches_names

    @app.install('twitter')
    assert_equal ['facebook', 'twitter'], @app.switches_names
  end

  def test_install_fail
    refute @app.install('myspace')
  end

  private

  def config_fixtures
    { :facebook => {
        :username => 'billy@droptables.com',
        :password => 'password',
        :killmode => 'password_reset'
      },
      :twitter => {
        :username => 'billy@droptables.com',
        :password => 'password',
        :killmode => 'password_reset'
      },
      :switches => ['facebook', 'twitter']
    }
  end
end