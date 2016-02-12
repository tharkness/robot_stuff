require_relative 'spec_helper'

describe Battery do

  before :each do
    @battery = Battery.new
    @robot = Robot.new
    @robot.shield_points = 25
  end

  describe '#recharge' do
    it "should restore 25 points to shields" do
      @battery.recharge(@robot)
      expect(@robot.shield_points).to eq(50)

    end
  end

end