require 'fiveinarow/version'
require 'fiveinarow/board'
require 'fiveinarow/cell'
require 'rubygems'
require 'gosu'

module Fiveinarow

  class Game < Gosu::Window



    def initialize
      super(800, 800, false)
      self.caption = 'Five In A Row'

      @board = Board.new(self, 22)



      @background = Gosu::Image.new(self, 'media/background_800_800.png')

      @last_milliseconds = 0
    end

    def draw
      @background.draw(0, 0, 0)
      # @cursor.draw self.mouse_x, self.mouse_y, 0
      @board.draw(mouse_x, mouse_y)
    end

    def needs_cursor?
      true
    end

    # this is a callback for key up events or equivalent (there are
    # constants for gamepad buttons and mouse clicks)
    def button_up(key)
      self.close if key == Gosu::KbEscape

      puts 'hello' if key == Gosu::MsLeft

      if key == Gosu::MsLeft
        @board.cell_clicked(mouse_x, mouse_y).set(Cell::PLAYER_A)
      end


    end


    def update
      self.update_delta
      # with a delta we need to express the speed of our entities in
      # terms of pixels/second
    end

    def update_delta
      # Gosu::millisecodns returns the time since the window was created
      # Divide by 1000 since we want to work in seconds
      current_time = Gosu::milliseconds / 1000.0
      # clamping here is important to avoid strange behaviors
      @delta = [current_time - @last_milliseconds, 0.25].min
      @last_milliseconds = current_time


    end
  end

  game = Game.new
  game.show

end