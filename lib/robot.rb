class Robot

  include Movement

  attr_reader :position
  attr_accessor :health, :equipped_weapon, :items

  def initialize
    @position = [0, 0]
    @items = []
    @health = 100
    @equipped_weapon = nil
  end

  def wound(damage)
    self.health -= damage
    if self.health < 0
      self.health = 0
    end
  end

  def heal(healing)
    self.health += healing
    if self.health > 100
      self.health = 100
    end
  end

  def heal!(healing)
    #binding.pry
    raise RobotAlreadyDeadError.new(self) if self.health <= 0
    self.health += healing
    if self.health > 100
      self.health = 100
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
    if @equipped_weapon == nil
      enemy.wound(5)
    else
      @equipped_weapon.hit(enemy)
    end
  end

  def capacity?
    items_weight >= 250
  end

  def pick_up(item)
    if capacity?
      false
    elsif item.is_a? Weapon
      self.equipped_weapon = item
    else
      @items << item
    end
  end

  def items_weight
    sum = 0
    @items.each do |x|
      sum = sum + x.weight
    end
    sum
  end

end
