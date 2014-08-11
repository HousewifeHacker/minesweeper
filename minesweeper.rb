require './board.rb'
require './tile.rb'

class MineSweeper
  def run
    @continue_game = true
    while @continue_game
      choice = main_menu
      case choice
      when 1
        create_new_board
      when 2
        puts "No."
      when 3
        @continue_game = false
      end
    end
  end

  private

  def create_new_board
    puts "How many mines do you want?"
    @board = Board.new(gets.chomp.to_i)
  end

  def main_menu
    display_menu
    get_user_choice
  end

  def display_menu
    puts 'Welcome to Minesweeper!'
    puts '-----------------------'
    puts '|     1. New game     |'
    puts '|     2. Load         |'
    puts '|     3. Exit         |'
    puts '-----------------------'
  end

  def get_user_choice
    choice = nil
    until (1..3).cover?(choice)
      choice = gets.chomp.to_i
    end
    choice
  end

end

if __FILE__ == $PROGRAM_NAME
  m = MineSweeper.new
  m.run
  #b = Board.new(9)
  #b.display
#  t = Tile.new([0, 1], b)
# p t.neighbors
end
