require_relative 'game'
require_relative 'ship'
require_relative 'player'
require_relative 'stories'
require 'set'

class Battleship
  attr_accessor :game
  include Stories

  def initialize
    @game ||= Game.new(10)
    @letters = %w[a b c d e f g h i j]
    @numbers = %w[0 1 2 3 4 5 6 7 8 9]
  end

  def next_move
    gets.chomp
  end

  def welcome
    welcome_story1
    welcome_story2
    board_set_up1
    place_first_ship_story
  end

  def place_first_ship_story
    player_ship_array
    puts 'To place a ship, enter the xy coordinates and a (v or h) for vertical or horizontal.'
  end

  def player_ship_array
    array = @game.who_is_playing.ships.collect(&:name)
    array
  end

  def show_player_board
    @game.player_board.display_board_view
  end

  def place_ships(player)
    count = 0
    board = player.id == 1 ? @game.board1 : @game.board0
    puts "Player #{player.id}, Please enter your ships:"
    player.player_ships.each do |ship|
      puts "Place #{ship.name} with #{ship.size} length"
    end
    ships = player.player_ships
    ship_names = ships.collect(&:name)
    while ships
      puts "Please enter x, y, orientation for #{ship_names[count]} i.e a0v - j9h"
      placement = gets.to_s
      next unless validate_coordinates(placement)
      response = place_ship_on_board(placement, board, ships, count)
      if response == 'Sorry the ship cannot go there'
        puts response
        next
      end
      ships.rotate
      ship_names.rotate
      count += 1
      if count == 5
        puts "Thank you Player#{player.id} for entering your ships"
        break
      end
    end
  end

  def set_board
    place_ships(@game.player0)
    place_ships(@game.player1)
  end

  def start_game
    move = ''
    while true do
      if @game.who_is_playing.id.zero?
        show_player_board
        puts 'Player0 please make a move: i.e a0 through j9'
        while true do
          move = next_move
          break if valid_move(move)
          puts 'invalid move, try again'
        end
      else
        show_player_board
        puts 'Player1 please make a move: i.e a0 through j9'
        while true do
          move = next_move
          break if valid_move(move)
          puts 'invalid move, try again'
        end
      end
      puts move
      @game.play_move(move[0].to_i, move[1].to_i)
      @game.play_turn
    end
  end

  def valid_move(move)
    if move.length == 2 &&
       @letters.include?(move[0]) &&
       @numbers.include?(move[1])
      true
    else
      false
    end
  end

  def place_ship_on_board(placement, board, ships, count)
    board.place_ship(placement[0].to_i,
                     placement[1].to_i,
                     placement[2],
                     ships[count])
  end

  def validate_coordinates(placement)
    unless placement.length == 4 &&
           (placement[2] == 'v' || placement[2] == 'h') &&
           @letters.include?(placement[0]) &&
           @numbers.include?(placement[1])
      puts 'Please reenter coordinates'
      false
    end
    true
  end
end

battle = Battleship.new
battle.welcome
battle.set_board
battle.start_game
