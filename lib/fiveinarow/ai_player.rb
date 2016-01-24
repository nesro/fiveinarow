require_relative 'generic_player'

class AIPlayer < GenericPlayer

  def make_move(board)
    ai(board)
    "prng = Random.new

    loop do
      row = prng.rand(0..board.size - 1)
      col = prng.rand(0..board.size - 1)

      if board.grid[row][col].e?
        board.grid[row][col].set(@sym)
        break
      end
    end"
  end


  def ai(board)
    if self.sym == Cell::PLAYER_A
      opsym = Cell::PLAYER_B
    else
      opsym = Cell::PLAYER_A
    end

    # 0 is EMPTY_CELL
    # 1 is AI (this one)
    # 2 is opponent
    # -1 is end of pattern

    [
        # my four, go for win
        [0, [0, 1, 1, 1, 1]],
        [1, [1, 0, 1, 1, 1]],
        [2, [1, 1, 0, 1, 1]],

        # his four, need to block
        [0, [0, 2, 2, 2, 2]],
        [1, [2, 0, 2, 2, 2]],
        [2, [2, 2, 0, 2, 2]],

        # my three, go for four
        [0, [0, 1, 1, 1, 0]],
        [2, [0, 1, 0, 1, 1]],
        [1, [1, 0, 1, 1, 0]],
        [1, [0, 0, 1, 1, 1]],

        # his three, need to block
        [0, [0, 2, 2, 2, 0]],
        [1, [2, 0, 2, 2, 0]],
        [1, [0, 2, 0, 2, 2]],

        # my two, let's make three
        [2, [0, 1, 0, 1, 0]],
        [1, [0, 0, 1, 1, 0]],
        [1, [0, 0, 1, 1, 0, 0]],

        # really nothing to do, lets make mark next to another
        [1, [0, 0, 1, 0, 0]],
        [1, [0, 0, 1, 0]],
        [0, [0, 1, 0]],

        # okay... so, just block something
        [1, [0, 0, 2, 0]],
        [0, [0, 2, 0]]

    ].each do |pattern|
      puts "pattern = #{pattern}"
      (0..board.size - 1).each do |row|
        (0..board.size - 1).each do |col|
          [[1, 1], [1, 0], [-1, 1], [0, 1], [-1, -1], [-1, 0], [1, -1], [0, -1]].each do |k|
            rd = k[0]
            cd = k[1]
            s = 0
            pattern[1].each_with_index.map do |pval, pind|
              if pval == 0
                break if board.on(row + rd*pind, col + cd*pind) != 0
              elsif pval == 1
                break if board.on(row + rd*pind, col + cd*pind) != self.sym
              elsif pval == 2
                break if board.on(row + rd*pind, col + cd*pind) != opsym
              end
              s += 1
            end
            if s == pattern[1].length
              board.mark_cell(row + rd*pattern[0], col+ cd*pattern[0], self.sym)
              return true
            end
          end
        end
      end
    end

    puts "oh shit"
    return false
  end
end
