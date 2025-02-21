require_relative "board"
# class Game automates and controls the rules of the game
class Game
  attr_accessor :board
  attr_reader :turn

  def initialize
    @board = Board.new
    @turn = 9
    @winner = nil
    @win = false
    @shape = nil
  end

  def start
    puts "Starting game..."
    @board.show_board
  end

  def lower_count
    @turn -= 1
  end

  def current_shape
    @shape = if @turn.even?
               :x
             else
               :o
             end
  end

  def current_winner
    @winner = if @turn.even?
                "Player 2"
              else
                "Player 1"
              end
  end

  # these methods collect the current items on the board

  def collect_row(row)
    collection = []
    3.times do |n|
      collection.push(board.grid[row][n])
    end
    collection
  end

  def collect_column(column)
    collection = []
    3.times do |n|
      collection.push(board.grid[n][column])
    end
    collection
  end

  def collect_cross_left
    collection = []
    3.times do |n|
      collection.push(board.grid[n][n])
    end
    collection
  end

  def collect_cross_right
    collection = []
    3.times do |n|
      collection.push(board.grid[2 - n][n])
    end
    collection
  end

  # this methods checks if the items collected are all identical

  def all_the_same?(array)
    return false unless array.uniq.length < 2 && array.include?(nil) == false

    true
  end

  # these methods check for wins!

  def check_for_column_win
    3.times do |column|
      @win = true if all_the_same?(collect_column(column)) == true
    end
  end

  def check_for_row_win
    3.times do |row|
      @win = true if all_the_same?(collect_row(row)) == true
    end
  end

  def check_for_cross_win
    @win = true if all_the_same?(collect_cross_left) == true || all_the_same?(collect_cross_right) == true
  end

  def check_for_win
    check_for_column_win
    check_for_row_win
    check_for_cross_win
  end

  # these methods set up the gameplay loop

  def finish
    return unless @win == true

    current_winner
    puts "#{@winner} has won the game!"
    @turn = 0
  end

  def prepare
    board.place_move(current_shape, gets.to_i, gets.to_i)
    lower_count
    board.show_board
    check_for_win
    finish
  end
end
