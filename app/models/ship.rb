class Ship
  attr_accessor :size, :name, :hits, :id, :coordinates

  def initialize(id)
    @id = id
    @size = get_size(id)
    @name = get_name(id)
    @hits ||= 0
    @coordinates = []
  end

  def ship_types
    {
      5 => [5, 'Aircraft Carrier'],
      4 => [4, 'Battleship'],
      3 => [3, 'Submarine'],
      2 => [3, 'Destroyer'],
      1 => [2, 'Patrol Boat']
    }
  end

  def get_size(id)
    ship_types[id][0]
  end

  def get_name(id)
    ship_types[id][1]
  end

  def assign_coordinates(x,y,orientation)
    clear_coordinates
    size = self.size
    size.times do
      marker = []
      marker << x
      marker << y
      if orientation == 'h'
        y += 1
      else
        x += 1
      end
      @coordinates << marker
    end
  end

  def clear_coordinates
    @coordinates = []
  end

end
