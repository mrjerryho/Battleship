require_relative 'ship'
require_relative 'player'
require_relative 'board'

class Game
  attr_accessor :board0, :board1, :player0, :player1, :turn

  def initialize(_size = 10)
    @board0 ||= Board.new
    @board1 ||= Board.new
    @player0 ||= Player.new
    @player1 ||= Player.new(1)
    @turn = 0
  end

  def opponent_board
    if @turn.zero?
      @board0
    else
      @board1
    end
  end

  def opponent
    if @turn.zero?
      @player0
    else
      @player1
    end
  end

  def player_board
    if @turn.zero?
      @board0
    else
      @board1
    end
  end

  def who_is_playing
    if @turn.zero?
      @player0
    else
      @player1
    end
  end

  def play_move(x, y)
    if opponent_board.return_status(x, y)
      'Invalid Play. Try again.'
    else
      if opponent_board.marker_taken?(x, y)
        opponent_board.place_status(x, y, 'hit')
        ship_id = opponent_board.return_ship_id(x, y)
        ship = opponent.find_ship(ship_id)
        puts 'found ship'
        puts ship.name
        status = []
        coords = ship.coordinates
        coords.each do |marker|
          mx = marker[0]
          my = marker[1]
          status << opponent_board.return_status(mx, my)
        end
        unless status.include?(nil)
          coords.each do |marker|
            mx = marker[0]
            my = marker[1]
            opponent_board.place_status(mx, my, 'sunk')
          end
        end
      else
        opponent_board.place_status(x, y, 'miss')
      end
      play_turn
    end
  end

  def play_turn
    if @turn.zero?
      @turn += 1
    else @turn = 0
    end
  end

  def find_ship(ship_id)
    ships = who_is_playing.ships.select do |ship|
      ship.id == ship_id
    end.first
  end

  def find_marker(x, y)
    player_board.find_marker(x, y)
  end

  def send_ship(x_letter, y, orientation, ship)
    x_coord = x_translate(x_letter)
    player_board.place_ship(x_coord, y, orientation, ship)
  end

  def x_translate(letter)
    letter = letter.upcase
    x_coord = ('A'..'J').zip(0..10)
    x_coord.select { |x| x[0] == letter }[0][1]
  end
end
