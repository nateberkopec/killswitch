require 'minitest/autorun'
require './lib/killswitch'
require './bin/killswitch'
require 'pry'

class TestKillswitch < MiniTest::Unit::TestCase

  def setup
    @app = Killswitch.new
    @path = '/tmp/test'
    @app.killer.config = Keep.new(@path)
    config_fixtures.each { |k, v| @app.killer.config.set(k, v) }
  end

  def teardown
    `rm -rf #{@path}`
  end

  def test_the_truth
    assert true
  end

  def test_killer
    assert_equal Killer, @app.killer.class
  end

  def test_killer_config_settings
    @app.killer.config.set('nuclear_launch_codes', '12345')

    assert_equal '12345', @app.killer.config.get('nuclear_launch_codes')
  end

  def test_killer_password_setting
    @app.killer.password = '12345'

    assert @app.killer.password == '12345'
    refute @app.killer.config.get('password_hash').to_s == "12345" #it isnt plaintext
  end

  def test_switches
    assert @app.killer.switches.length == 2
    assert @app.killer.switches.first.class == FacebookSwitch
    assert @app.killer.switches.first.name == "facebook"
  end

  def test_killer_kill
    @app.killer.config.set(:switches, ['facebook'])

    @app.killer.switches.first.stub :kill!, true do
      assert @app.killer.kill! == [true]
    end
  end

  def test_uninstall
    @app.killer.uninstall('twitter')

    assert_equal ['facebook'], @app.killer.switches.map {|s| s.name}
  end

  private

  def config_fixtures
    { :facebook => {
        :username => 'billy@droptables.com',
        :password => '12345',
        :killmode => 'password'
      },
      :twitter => {
        :username => 'billy@droptables.com',
        :password => '12345',
        :killmode => 'password'
      },
      :switches => ['facebook', 'twitter']
    }
  end
end