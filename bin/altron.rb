################################################################################

# freeplay --host 66.175.219.57 altron.rb

class AlTron < Freeplay::Player

  ##############################################################################
  def move
    x, y = nil, nil

    # First attempt
    if board.last_opponent_move
      logger.info("1: searching to go to top/right open space")

      allowed = board.adjacent(*board.last_opponent_move)
      match = allowed.find_all{|(ax, ay)|board[ax, ay] == :empty}
      x, y = match.sort.last
      end

    #second try
    if x.nil? or y.nil?
      logger.info("2: searching for first available space")

      x, y = catch(:found_empty_space) do
        board.size.times do |bx|
          board.size.times do |by|
            throw(:found_empty_space, [bx, by]) if board[bx, by] == :empty
          end
        end
      end
    end

    [x, y]

  end
end







