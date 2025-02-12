require_relative "board"
# class Game automates and controls the rules of the game
class Game
  attr_accessor :board
  attr_reader :turn

  def initialize
    @board = Board.new
    @turn = 9
    @winner = nil
    @shape = nil
  end

  def start
    puts "Starting game..."
    @board.show_board
  end

  def lower_count
    @turn -= 1
  end

  def make_winner(array)
    @winner = if array[0] == :o && @turn < 5
                "Player 1"
              else
                "Player 2"
              end
  end

  def current_shape
    @shape = if @turn.even?
               :x
             else
               :o
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

  # these methods check for wins by seeing if the items collected are all identical

  def all_the_same?(array)
    return false unless array[0] == array[1] && array[1] == array[2]

    true
  end

  # From here the methods need to be rewritten so that they are more individualized and don't call make_winner each time
  # what should these values *return*
  def check_row_win
    3.times do |n|
      collection = collect_row(n)
      all_the_same?(collection) == true
    end
  end

  def check_cross_win
    collection_left = collect_cross_left
    collection_right = collect_cross_right
  end

  def check_column_win
    3.times do |n|
      collection = collect_column(n)
      all_the_same?(collection)
    end
  end

  def check_for_win
    check_row_win
    check_cross_win
    check_column_win
  end

  # basically. the process behind make_winner needs to be more complex

  def finish
    return if @winner.nil? == false

    @turn = 0
    puts "#{@winner} has won the game!"
  end

  # these methods set up the gameplay loop

  def prepare
    board.place_move(current_shape, gets.to_i, gets.to_i)
    lower_count
    board.show_board
    check_for_win
    finish
  end
end
