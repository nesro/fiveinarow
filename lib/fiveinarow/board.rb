require_relative 'cell'

require 'rubygems'
require 'gosu'

class Board
  def initialize(window, size)
    @window = window
    @size = size
    @grid = Array.new(size) { Array.new(size) }

    (0..(@size - 1)).each do |row|
      (0..(@size - 1)).each do |col|
        @grid[row][col] = Cell.new(row, col, Cell::EMPTY)
      end
    end

    @cell_empty = Gosu::Image.new(@window, 'media/cell_white_35_35.png')
    @cell_a = Gosu::Image.new(@window, 'media/cell_x_35_35.png')
    @cell_b = Gosu::Image.new(@window, 'media/cell_o_35_35.png')

  end

  CELL_SIZE=36.55


  def cell_clicked(mx, my)
    mx2 = ((mx - (CELL_SIZE/2)) / CELL_SIZE).round
    my2 = ((my - (CELL_SIZE/2)) / CELL_SIZE).round
    puts "row=#{@grid[my2][mx2].row} col=#{@grid[my2][mx2].col} val=#{@grid[my2][mx2].value}"
    @grid[mx2][my2]
  end

  def draw(mx, my)
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
    #puts "mx=#{mx} mx2=#{mx2}"
    @cell_b.draw(mx2 * CELL_SIZE, my2 * CELL_SIZE, 1)

  end
end