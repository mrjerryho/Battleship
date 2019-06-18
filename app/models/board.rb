class Board

  attr_accessor :board_view

  def initialize(size=10)
    @board_view ||= make_board(size)
  end

  def make_board(size)
    Array.new(size) { Array.new(size)}
  end

  def find_ship_markers(ship)
    ship.coordinates
  end

  def marker_taken?(x, y)
    marker = find_marker(x, y)
    if find_marker(x, y)
      marker.any?{ |i| i.class == Fixnum }
    end
  end

  def return_ship_id(x, y)
    marker = find_marker(x, y)
    ship_id = marker.grep(Fixnum)
    ship_id[0]
  end

  def return_status(x, y)
    marker = find_marker(x, y)
    if find_marker(x, y)
      status = marker.grep(String)
      status[0]
    end
  end

  def place_ship(x, y, orientation, ship)
    ship_id = ship.id
    if !validate_placement(x, y, ship, orientation)
      answer = 'Sorry the ship cannot go there'
    else
      coordinates = ship.coordinates
      puts coordinates
      coordinates.each do |marker|
        mx = marker[0]
        my = marker[1]
        place_ship_mark(mx, my, ship_id)
        answer = 'Ship placed'
      end
    end
    answer
  end

  def validate_placement(x, y, ship, orientation)
    valid = true
    ship.assign_coordinates(x, y, orientation)
    coordinates = ship.coordinates
    coordinates.each do |marker|
      x = marker[0]
      y = marker[1]
      next unless marker_taken?(x, y)
      ship.clear_coordinates
      valid = false
      break
    end
    valid
  end

  def place_status(x, y, status)
    if find_marker(x, y)
      if return_status(x, y)
        @board_view[x][y].delete(return_status(x, y))
      end
      @board_view[x][y] << status
    else
      @board_view[x][y] = [status]
    end
  end

  def place_ship_mark(x, y, ship_id)
    @board_view[x][y] = [ship_id]
  end

  def find_marker(x, y)
    @board_view[x][y]
  end

  def show_only_status(x, y)
    ans = return_status(x, y) ? return_status(x, y) : ' x '
    ans
  end

  def opponent_view
    row = 0
    puts
    print %w[_ a b c d e f g h i j]
    puts
    y = 0
    10.times do
      array = []
      x = 0
      10.times do
        array << show_only_status(x, y)
        x += 1
      end
      puts "#{row} #{array}"
      y += 1
      row += 1
    end
  end

  def display_board_view
    row = 0
    puts
    print %w[_ a b c d e f g h i j]
    puts
    10.times do
      print "#{row} #{board_view[row]}"
      puts
      row += 1
    end
  end

end
