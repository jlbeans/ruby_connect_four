# frozen_string_literal

require_relative 'cage'
require_relative 'player'

# controls game flow
class Game
  attr_accessor :player_one, :player_two, :current_player, :cage

  def initialize(cage = Cage.new)
    @cage = cage
    @player_one = Player.new('Player 1', 'X')
    @player_two = Player.new('Player 2', 'O')
    @current_player = @player_one
    start
  end

  def start
    puts "Welcome to a command line game of connect four!
    In this game, player one will have the token 'X', and player
    two will have the token 'O'.  The goal is to connect 4 of your
    tokens before the other player does.  You can win by connecting
    them horizontally in a row, vertically in a column, or in
    a diagonal.  Let's begin!"
    new_game
  end

  def new_game
    cage.display_cage
    play_loop
    game_results
    repeat
  end

  def play_loop
    loop do
      turn(current_player)
      cage.display_cage
      break if game_over?

      switch_current_player
    end
  end

  def turn(player)
    col_num = player_input(player)
    move = cage.drop_token(col_num, player.token)
    if move.nil?
      puts 'Sorry, that column is already full!'
      turn(player)
    else
      move
    end
  end

  def player_input(player)
    puts "#{player.name}, which column number would you like to place your token? (1-7)"
    choice = gets.chomp.to_i
    if cage.valid_choice?(choice)
      choice
    else
      puts 'Number must be between 1 and 7!'
      player_input(player)
    end
  end

  def switch_current_player
    @current_player = @current_player == @player_one ? @player_two : @player_one
  end

  def game_over?
    return true if cage.winner? || @cage.cage_full?
  end

  def game_results
    if cage.winner?
      puts "Congrats #{current_player.name}, you've won!"
    else
      puts 'Tie game!'
    end
  end

  def repeat
    puts 'Would you like to play again? (Y/N)'
    answer = gets.chomp.upcase
    if answer == 'Y'
      Game.new
    else
      puts 'Thanks for playing!'
    end
  end
end

Game.new
