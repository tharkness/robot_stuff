class RobotAlreadyDeadError < StandardError

  def initialize(robot)
    super("robot is already dead and cannot be healed.")
  end

end


class UnattackableEnemyError < StandardError

  def initialize(robo)
    super("Can't attack a non-robot!")
  end

end