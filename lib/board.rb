class InvalidMove < StandardError
end

# class Board that holds the marks
class Board
  attr_accessor :turns
  attr_reader :num_rows, :num_cols, :grid

  def initialize
    @num_rows = 3
    @num_cols = 3
    @grid = Array.new(@num_rows) { Array.new(@num_cols) }
  end

  # type needs be one of :x, :o
  # row & col need to be between 0-2
  def place_move(type, row, col)
    raise InvalidMove.new(message: "Type must be one of :x or :o") unless %i[x o].include?(type)
    raise InvalidMove.new(message: "row and col values must be between 0-2") unless row.between?(0,
                                                                                                 2) && col.between?(0,
                                                                                                                    2)

    grid[row][col] = type
  end

  def show_board
    grid.each do |row|
      p row
    end
  end

  def fill_board(filler)
    grid.each do |row|
      num_cols.times do |n|
        row[n] = filler
      end
    end
  end

  def fill_column(filler, column)
    grid.each do |row|
      row[column] = filler
    end
  end

  def fill_row(filler, row)
    num_cols.times do |n|
      grid[row][n] = filler
    end
  end

  def fill_cross_left(filler)
    num_rows.times do |n|
      grid[n][n] = filler
    end
  end

  def fill_cross_right(filler)
    num_rows.times do |n|
      grid[2 - n][n] = filler
    end
  end
end
