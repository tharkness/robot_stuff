class Robot

  MAX_WEIGHT = 250
  MAX_HEALTH = 100
  MAX_SHIELD = 50

  include Movement

  attr_reader :position
  attr_accessor :health, :equipped_weapon, :items, :range, :shield_points, :position

  def initialize
    @position = [0, 0]
    @items = []
    @health = MAX_HEALTH
    @equipped_weapon = nil
    @shield_points = MAX_SHIELD
  end

  def wound(damage)
    self.shield_points -= damage if self.shield_points > 0
    self.health -= damage
    if self.health < 0
      self.health = 0
    end
  end

  def heal(healing)
    self.health += healing
    if self.health > MAX_HEALTH
      self.health = MAX_HEALTH
    end
  end

  def charge(charge)
    self.shield_points += charge
    if self.shield_points > MAX_SHIELD
      self.shield_points = MAX_SHIELD
    end
  end

  def heal!(healing)
    #binding.pry
    raise RobotAlreadyDeadError.new(self) if self.health <= 0
    self.health += healing
    if self.health > MAX_HEALTH
      self.health = MAX_HEALTH
    end
  end

  def attack!(enemy)
    raise UnattackableEnemyError.new(self) if enemy.is_a?(Robot) == false
    if @equipped_weapon == nil
      enemy.wound(5)
    else
      @equipped_weapon.hit(enemy)
    end
  end

  def attack(enemy)
    x = enemy.position[0]
    y = enemy.position[1]
    case equipped_weapon
    when Weapon
      if ((x - self.position[0]).abs > equipped_weapon.range) || ((y - self.position[1]).abs > equipped_weapon.range)
        puts "Enemy is out of range."
      else
        @equipped_weapon.hit(enemy)
        @equipped_weapon = nil if @equipped_weapon.is_a?(Grenade)
      end
    when nil
      if ((x - self.position[0]).abs > 1) || ((y - self.position[1]).abs > 1)
        puts "Enemy is out of range"
      else
        enemy.wound(5)
      end
    end
  end

  def capacity?
    items_weight >= MAX_WEIGHT
  end

  def pick_up(item)
    if capacity?
      false
    elsif item.weight > MAX_WEIGHT
      false
    elsif item.is_a?(BoxOfBolts) && self.health <= 80
      item.feed(self)
    elsif item.is_a? Weapon
      self.equipped_weapon = item
    else
      @items << item
    end
  end

  def items_weight
    @items.reduce(0) { |sum, item| sum + item.weight }
  end

  def self.list_robots
    ObjectSpace.each_object(self).to_a
  end

  def in_position(x, y)
    axis = []
    ObjectSpace.each_object(Robot) do |robot|
      if robot.position == [x, y]
        axis << robot
      end
    end
    axis
  end

  def scan
    result = []
    first = self.position[0]
    second = self.position[1]
    result += self.in_position(first + 1, second)
    result += self.in_position(first - 1, second)
    result += self.in_position(first, second + 1)
    result += self.in_position(first, second - 1)
    result
  end

end
