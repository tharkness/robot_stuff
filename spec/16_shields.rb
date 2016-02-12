require_relative 'spec_helper'

describe Robot do

  before :each do
    @robot = Robot.new
  end

  describe '#wound' do
    it "should damage shields if shields are active." do
      @robot.wound(10)      
      expect(@robot.shield_points).to eq(40)
    end
  end

  describe '#wound' do
    it "should damage health if shields are down." do
      @robot.shield_points = 0
      @robot.wound(10)
      expect(@robot.health).to eq(90)
    end
  end
end