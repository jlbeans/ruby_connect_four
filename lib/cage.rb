# frozen_string_literal: true

# renders board and board moves
class Cage
  attr_accessor :cage

  def initialize
    @cage = Array.new(6) { Array.new(7, '*') }
  end

  def display_cage
    display = <<-CAGE
    1   2   3   4   5   6   7
  | #{@cage[0][0]} | #{@cage[0][1]} | #{@cage[0][2]} | #{@cage[0][3]} | #{@cage[0][4]} | #{@cage[0][5]} | #{@cage[0][6]} |
  | #{@cage[1][0]} | #{@cage[1][1]} | #{@cage[1][2]} | #{@cage[1][3]} | #{@cage[1][4]} | #{@cage[1][5]} | #{@cage[1][6]} |
  | #{@cage[2][0]} | #{@cage[2][1]} | #{@cage[2][2]} | #{@cage[2][3]} | #{@cage[2][4]} | #{@cage[2][5]} | #{@cage[2][6]} |
  | #{@cage[3][0]} | #{@cage[3][1]} | #{@cage[3][2]} | #{@cage[3][3]} | #{@cage[3][4]} | #{@cage[3][5]} | #{@cage[3][6]} |
  | #{@cage[4][0]} | #{@cage[4][1]} | #{@cage[4][2]} | #{@cage[4][3]} | #{@cage[4][4]} | #{@cage[4][5]} | #{@cage[4][6]} |
  | #{@cage[5][0]} | #{@cage[5][1]} | #{@cage[5][2]} | #{@cage[5][3]} | #{@cage[5][4]} | #{@cage[5][5]} | #{@cage[5][6]} |
    CAGE
    puts display
  end

  def row(current)
    row = cage.length
    row - current
  end

  def col(num)
    num - 1
  end

  def drop_token(num, token, current = 1)
    return nil if current > 6

    if @cage[row(current)][col(num)] != '*'
      drop_token(num, token, current + 1)
    else
      @cage[row(current)][col(num)] = token
    end
  end

  def winner?
    true if four_in_a_row? || four_in_a_column? || four_in_a_diagonal?
  end

  def four_in_a_row?
    0.upto(3) do |y|
      0.upto(5) do |x|
        if (@cage[x][y] != '*') &&
           ([@cage[x][y + 1]] & [@cage[x][y + 2]] & [@cage[x][y + 3]] == [@cage[x][y]])
          return true
        end
      end
    end
    false
  end

  def four_in_a_column?
    0.upto(6) do |y|
      0.upto(2) do |x|
        if (@cage[x][y] != '*') &&
           ([@cage[x + 1][y]] & [@cage[x][y]] & [@cage[x + 2][y]] & [@cage[x + 3][y]] == [@cage[x][y]])
          return true
        end
      end
    end
    false
  end

  def four_in_a_diagonal?
    0.upto(3) do |y|
      0.upto(2) do |x|
        if (@cage[x][y] != '*') &&
           ([@cage[x + 1][y + 1]] & [@cage[x + 2][y + 2]] & [@cage[x + 3][y + 3]] == [@cage[x][y]])
          return true
        end
      end
    end
    6.downto(3) do |y|
      0.upto(2) do |x|
        if (@cage[x][y] != '*') &&
           ([@cage[x + 1][y - 1]] & [@cage[x + 2][y - 2]] == [@cage[x][y]])
          return true
        end
      end
    end
    false
  end

  def cage_full?
    cage.all? { |row| row.none? { |slot| slot == '*' } }
  end

  def valid_choice?(input)
    return true if input.between?(1, 7)
  end
end
