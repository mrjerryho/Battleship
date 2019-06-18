module Stories

  def welcome_story1
    puts "Welcome to Battleship! Two players can play
    and the idea is to sink the other player's ships. What could be better than that?"
    puts 'Each player has 5 boats of different sizes.'
    puts "Let's start with Player 0. Player 1... look away."
    puts "Press any key to continue when you're ready..."
    next_move
  end

  def welcome_story2
    puts "Great. Let's place your five ships"
  end

  def board_set_up1
    puts 'Here is your board.'
    show_player_board
  end

end
