require 'test_helper'

class RobotTest < Minitest::Test
  def setup
    @robot = Otacrawler::Robot.new
  end

  def test_sites
    assert_instance_of Otacrawler::Sites::TonariNoYJ, @robot.sites.first
  end
end
