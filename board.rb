require './tile.rb'

class Board
  attr_accessor :board
  def initialize(bomb_number)
    @bomb_number = bomb_number
    self.board = Array.new(9) {Array.new(9)}
    9.times do |row|
      9.times do |col|
        self.board[row][col] = Tile.new([row, col], self)
      end
    end
    generate_bomb_positions.each do |pos|
      get_tile(pos).arm_mine
    end
  end

  def generate_bomb_positions
    array = (0..80).to_a.shuffle
    bomb_positions = []
    @bomb_number.times do
      pos = array.pop
      bomb_positions << [pos / 9, pos % 9]
    end
    bomb_positions
  end

  def reveal(pos)
    get_tile(pos).reveal
  end

  def toggle_flag(pos)
    get_tile(pos).toggle_flag
  end

  def display
    puts "    1  2  3  4  5  6  7  8  9 "
    self.board.each.with_index do |row, i|
      print " #{i + 1}|"
      row.each do |el|
        print el.symbol
      end
      puts
    end
  end

  def get_tile(pos)
    self.board[pos.first][pos.last]
  end

  def explode?
    self.board.flatten.any? { |tile| tile.explode? }
  end

  def winner?
    self.board.flatten.all? {|tile| tile.flagged_bomb? || tile.revealed_empty?}
  end
end

