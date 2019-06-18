class Player
  attr_accessor :ships, :id

  def initialize(id=0)
    @ships ||= player_ships
    @id = id
  end

  def player_ships
    @ships = []
    @ships << Ship.new(1)
    @ships << Ship.new(2)
    @ships << Ship.new(3)
    @ships << Ship.new(4)
    @ships << Ship.new(5)
  end

  def find_ship(id)
    id -= 1
    @ships[id]
  end
end
