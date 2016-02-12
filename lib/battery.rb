class Battery < Item

  def initialize
    super("Battery", 25)
  end

  def recharge(robot)
    if robot.is_a?(Robot)
      robot.charge(25)
    end
  end

end