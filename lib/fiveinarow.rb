require 'fiveinarow/version'
require 'fiveinarow/board'
require 'fiveinarow/cell'
require 'fiveinarow/hotseat_player'
require 'fiveinarow/ai_player'
require 'fiveinarow/z_order'
require 'rubygems'
require 'gosu'

# Main module
module Fiveinarow
  # Main object
  class Game < Gosu::Window
    # Whether is game or the end of a game
    attr_accessor :state

    def initialize(root_dir)
      super(800, 800, false)
      self.caption = 'Five In A Row'
      @root_dir = root_dir
      @board = Board.new(self, 22, root_dir)

      @player_a = HotseatPlayer.new(Cell::PLAYER_A)
      @player_b = AIPlayer.new(Cell::PLAYER_B)
      @player_b.ai_dumb = 100

      @player_on_turn = @player_a

      @font = Gosu::Font.new(60)

      @background = Gosu::Image.new(self, File.join(root_dir, 'lib/media/background_800_800.png'))
      @the_end = Gosu::Image.new(self, File.join(root_dir, 'lib/media/the_end_800_800.png'))
      @last_milliseconds = 0
    end

    # draw the board
    def draw
      @background.draw(0, 0, ZOrder::Background)
      @board.draw(mouse_x, mouse_y, @player_on_turn.sym)
      if @state == :end
        @the_end.draw(0, 0, ZOrder::TheEnd)
      end
    end

    # yes we need the cursor to be visible
    def needs_cursor?
      true
    end

    # this is a callback for key up events or equivalent (there are
    # constants for gamepad buttons and mouse clicks)
    def button_up(key)
      close if key == Gosu::KbEscape

      # reset the game
      if @state == :end && key == Gosu::MsLeft
        @board = Board.new(self, 22, @root_dir)
        @state = :game
        return
      end

      @player_b.ai_inc if key == Gosu::KbS
      @player_b.ai_dec if key == Gosu::KbD

      if @player_on_turn.class == HotseatPlayer && key == Gosu::MsLeft
        if @board.cell_clicked(mouse_x, mouse_y, @player_on_turn.sym)

          return if @state == :end

          switch_players

          if @player_on_turn.class == AIPlayer
            @player_on_turn.make_move(@board)
            switch_players
          end
        end
      end
    end

    def switch_players
      if @player_on_turn == @player_a
        @player_on_turn = @player_b
      else
        @player_on_turn = @player_a
      end
    end

    def update
      update_delta
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
end
