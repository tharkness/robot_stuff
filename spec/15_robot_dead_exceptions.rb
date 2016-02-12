require_relative 'spec_helper'

describe Robot do

  before :each do
    @robot = Robot.new
    @item = Item.new("something", 14)
  end

  describe '#heal!' do
    it "should raise an error if robot has 0 or less health." do
      allow(@robot).to receive(:health).and_return(0)
      expect {@robot.heal!(10)}.to raise_exception(RobotAlreadyDeadError)
    end
  end

  describe '#attack!' do
    it "should raise an error if the enemy is not a robot." do
      expect {@robot.attack!(@item)}.to raise_exception(UnattackableEnemyError)
    end
  end

end