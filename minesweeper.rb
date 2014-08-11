class MineSweeper
  def initialize
  end
end

class Board
  attr_accessor :board
  def initialize
    self.board = Array.new(9, Array.new(9))
    9.times do |row|
      9.times do |col|
        self.board[row][col] = Tile.new([row, col], self)
      end
    end
  end

  def display
    self.board.each do |row|
      row.each do |el|
        print el.symbol
      end
      puts
    end
  end
end

class Tile
  def initialize(location, board)
    @bomb, @revealed, @flagged = false, false, false
  end

  def symbol
    return " * " if !@revealed && !@flagged
    return " _ " if @revealed && !@bomb

  end
end

if __FILE__ == $PROGRAM_NAME
  b = Board.new
  b.display
end