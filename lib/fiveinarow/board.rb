require_relative 'cell'

require 'rubygems'
require 'gosu'

class Board
  attr_accessor :size
  attr_accessor :grid

  def initialize(game, size)
    @game = game
    @size = size
    @grid = Array.new(size) { Array.new(size) }

    (0..(@size - 1)).each do |row|
      (0..(@size - 1)).each do |col|
        @grid[row][col] = Cell.new(row, col, Cell::EMPTY)
      end
    end

    @cell_empty = Gosu::Image.new(@game, 'media/cell_white_35_35.png')
    @cell_a = Gosu::Image.new(@game, 'media/cell_x_35_35.png')
    @cell_b = Gosu::Image.new(@game, 'media/cell_o_35_35.png')

  end

  def on(row, col)
    return 0 if row < 0
    return 0 if row >= @size
    return 0 if col < 0
    return 0 if col >= @size
    @grid[row][col].value
  end

  def is_winning_move(row, col)
    v = @grid[row][col].value

    [[1,1], [1,0], [-1,1], [0,1]].each do |i|
      s = 0
      rd = i[0]
      cd = i[1]
      (1..4).each do |j|
        break if v != @grid[row + rd*j][col + cd*j].value
        s += 1
      end
      rd = -rd
      cd = - cd
      (1..4).each do |j|
        break if v != @grid[row + rd*j][col + cd*j].value
        s += 1
      end

      return true if s >= 4
    end

    return false
  end

  def mark_cell(row, col, v)
    return false if !@grid[row][col].e?
    @grid[row][col].set(v)

    puts "marking cell row=#{row} col=#{col} v=#{v}"

    if is_winning_move(row, col)
      @game.state = :end
      puts "winning!!"
    end

    true
  end



  CELL_SIZE=36.55


  # return true if the cell has changed
  def cell_clicked(mx, my, v)
    mx2 = ((mx - (CELL_SIZE/2)) / CELL_SIZE).round
    my2 = ((my - (CELL_SIZE/2)) / CELL_SIZE).round
    mark_cell(mx2, my2, v)
  end

  def draw(mx, my, cursor)
    (0..(@size - 1)).each do |i|
      (0..(@size - 1)).each do |j|
        x = i*CELL_SIZE
        y = j*CELL_SIZE

        #puts "drawing i=#{i} j=#{j} c=#{@grid[i][j].value}"

        if @grid[i][j].e?
          @cell_empty.draw(x, y, 1)
        elsif @grid[i][j].a?
          @cell_a.draw(x, y, 1)
        elsif @grid[i][j].b?
          @cell_b.draw(x, y, 1)
        else
          puts "a ou"
        end



        # Gosu::draw_quad(x-size, y-size, 0xffffffff, x+size, y-size, 0xffffffff, x-size, y+size, 0xffffffff, x+size, y+size, 0xffffffff, 0)
      end
    end

    mx2 = ((mx - (CELL_SIZE/2)) / CELL_SIZE).round
    my2 = ((my - (CELL_SIZE/2)) / CELL_SIZE).round
    if @grid[mx2][my2].e?
      if cursor == 1
        @cell_a.draw(mx2 * CELL_SIZE, my2 * CELL_SIZE, 1)
      elsif cursor == 2
        @cell_b.draw(mx2 * CELL_SIZE, my2 * CELL_SIZE, 1)
      end
    end
  end
end