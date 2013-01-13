require 'minitest/autorun'
require './lib/killswitch'
require './bin/killswitch'
require 'pry'

class TestKillswitch < MiniTest::Unit::TestCase

  def setup
    @app = Killswitch.new
    @path = '/tmp/test'
    @app.killer.config = Keep.new(@path)
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
    @app.killer.config.set(:switches, 'facebook')

    assert @app.killer.switches.length == 1
    assert @app.killer.switches.first.class == FacebookSwitch
  end
end