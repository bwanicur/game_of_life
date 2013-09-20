require_relative 'grid'
require_relative 'visualizer'

class GrimReaper
    
    SEED_FILE = ARGV[0]
    @@count = 1 
    
    def self.start_game!
      @@grid = Grid.new(SEED_FILE)
      while(true)
        Visualizer.ascii(@@grid)
        next_turn
        sleep(0.25)
      end
    end
    
    private

    def self.next_turn
      @@grid.next_turn!
      @@count +=1
    end
    
end

GrimReaper.start_game!
