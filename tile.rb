require './board'

class Tile
  def initialize(location, board)
    @bomb, @revealed, @flagged = false, false, false
    @location = location
    @board = board
  end

  def arm_mine
    @bomb = true
  end

  def armed?
    @bomb
  end

  def toggle_flag
    @flagged = !@flagged
  end

  def symbol
    return " F " if @flagged
    return " * " if !@revealed && !@flagged
    return " _ " if @revealed && neighbor_bomb_count == 0
    return " #{neighbor_bomb_count} " if @revealed && !@bomb
    return "!X!"
  end

  def in_bounds(pos)
    pos.all? { |coord| (0..8).cover?(coord) }
  end

  def neighbors
    neighbor_list = []
    (-1..1).each do |row|
      (-1..1).each do |col|
        next if [row, col] == [0,0]
        pos = [@location.first + row, @location.last + col]
        neighbor_list <<  @board.get_tile(pos) if in_bounds(pos)
      end
    end
    neighbor_list
  end

  def reveal
    @revealed = true unless @flagged
    if neighbor_bomb_count == 0
      neighbors.each do |neighbor|
        neighbor.reveal unless neighbor.revealed?
      end
    end
  end

  def revealed?
    @revealed
  end

  def explode?
    @revealed && @bomb
  end

  def neighbor_bomb_count
    count = 0
    neighbors.each do |tile|
      count += 1 if tile.armed?
    end
    count
  end
end
