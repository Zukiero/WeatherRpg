class Player
  attr_accessor :name, :player_class, :life_points
  MAXIMUM_SHIELD_POINTS = 100
  POTION_BONUS = 1.25
  SHIELD_DAMAGE = 0.5
  CHARACTER_CLASS = {
    "Warrior" => {
      life_points: 100,
      shield_points: 100,
      potion_percentage: 1.0,
      attack_percentage: 1.0
    }, "Priest" => {
      life_points: 100,
      shield_points: 0,
      potion_percentage: 1.25,
      attack_percentage: 0.75
    }, "Thief" => {
      life_points: 100,
      shield_points: 0,
      potion_percentage: 1.0,
      attack_percentage: 1.5
    }
  }
  CHARACTER_ACTION = { "Attack" => :attack, "Defend" => :defend, "Use potion" => :use_potion }

  def initialize(name, player_class)
    @name = name
    @player_class = player_class
    @life_points = CHARACTER_CLASS[player_class][:life_points]
    @shield_points = CHARACTER_CLASS[player_class][:shield_points]
    @attack_percentage = CHARACTER_CLASS[player_class][:attack_percentage]
    @potion_percentage = CHARACTER_CLASS[player_class][:potion_percentage]
  end

  def attack(opponent)
    opponent.hit(damage)
  end

  def hit(damage)
    effective_damage = damage - (damage * @shield_points / 100)
    @shield_points = @shield_points * SHIELD_DAMAGE

    @life_points -= effective_damage
  end

  def defend
    return if @shield_points > MAXIMUM_SHIELD_POINTS

    @shield_points = 100
  end

  def use_potion
    @life_points = @life_points * POTION_BONUS * @potion_percentage
  end

  def info
    { "Life Points" => @life_points, "Shield Points" => @shield_points }
  end

  def damage
    Random.rand(10..100) * @attack_percentage
  end

  def action(action, opponent)
    send(action, opponent)
  rescue ArgumentError
    send(action)
  end
end

