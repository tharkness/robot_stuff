require_relative 'spec_helper'

describe Robot do

  before :each do
    @robot_1 = Robot.new
    @robot_2 = Robot.new
  end

  describe '#list_robots' do
    it "should return an array of all robots." do
      expect(Robot.list_robots.length).to eq(2)
    end
  end

end