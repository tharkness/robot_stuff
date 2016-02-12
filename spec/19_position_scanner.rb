require_relative 'spec_helper'
require_relative '../lib/movement'
require_relative '../lib/robot'

describe Robot do

  before :each do
    @robot = Robot.new
    @robot_two = Robot.new
    @robot_three = Robot.new
    @robot_two.position = [0, 1]
    @robot_three.position = [0, -1]
  end

  describe '#scan' do
    it 'should return the two robots adjacent.' do
      expect(@robot.scan).to eq([@robot_two, @robot_three])
    end
  end


end