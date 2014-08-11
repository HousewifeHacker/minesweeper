require './board'

class Tile
  def initialize(location, board)
    @bomb, @revealed, @flagged = false, false, false
    @location = location
    @board = board
  end

  def symbol
    return " F " if @flagged
    return " * " if !@revealed && !@flagged
    return " _ " if revealed_empty? && neighbor_bomb_count == 0
    return " #{neighbor_bomb_count} " if revealed_empty?
    return "!X!"
  end

  def neighbors
    neighbor_list = []
    (-1..1).each do |row|
      (-1..1).each do |col|
        next if [row, col] == [0,0]
        pos = [@location.first + row, @location.last + col]
        neighbor_list <<  @board.get_tile(pos) if in_bounds?(pos)
      end
    end
    neighbor_list
  end

  def neighbor_bomb_count
    count = 0
    neighbors.each do |tile|
      count += 1 if tile.armed?
    end
    count
  end

  def toggle_flag
    if @revealed
      puts "You already revealed this square!"
      return
    end
    @flagged = !@flagged unless @revealed
  end

  def reveal
    if @flagged
      puts "You have to unflag this square before you can reveal it!"
      return
    elsif @revealed
      puts "You already revealed this square!"
      return
    end

    @revealed = true
    if neighbor_bomb_count == 0
      neighbors.each do |neighbor|
        neighbor.reveal unless neighbor.revealed?
      end
    end
  end

  def arm_mine
    @bomb = true
  end

  def armed?
    @bomb
  end

  def in_bounds?(pos)
    pos.all? { |coord| (0..8).cover?(coord) }
  end

  def revealed_empty?
    @revealed && !@bomb
  end

  def flagged_bomb?
    @flagged && @bomb
  end

  def revealed?
    @revealed
  end

  def explode?
    @revealed && @bomb
  end
end
