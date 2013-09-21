class Cell
    
    attr_accessor :state, :next_state, :num_alive_neighbors, :row, :col
    
    # state = :alive or :dead
    def initialize(state, row, col)
      @state, @row, @col = state, row, col
      @next_state, @num_alive_neighbors = nil, nil
    end
   
    def calculate_next_state! 
      if alive?
        @next_state = [2,3].include?(@num_alive_neighbors) ? :alive : :dead
      else
        @next_state = @num_alive_neighbors == 3 ? :alive : :dead
      end
    end

    def alive?
      @state == :alive
    end

    def dead?
      @state == :dead
    end

    def update_state!
      @state = @next_state
      @next_state = nil
      @num_alive_neighbors = nil
    end
    
end

