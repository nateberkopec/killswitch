require 'minitest/autorun'
require './lib/killswitch'
require './bin/killswitch'

class TestKillswitch < MiniTest::Unit::TestCase

  def setup
    @app = Killswitch.new
  end

  def test_the_truth
    assert true
  end

  def test_killer
    assert_equal Killer, @app.killer.class
  end
end