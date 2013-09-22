require_relative 'seed_file_parser'
require_relative 'grid'
require_relative 'visualizer'

class GrimReaper
    
    SEED_FILE = ARGV[0]
    @@count = 1 
    
    def self.start_game!
      seed_data = SeedFileParser.parse_file(SEED_FILE)
      @@grid = Grid.new(seed_data)
      while(true)
        Visualizer.ascii(@@grid)
        next_turn
        sleep(0.25)
      end
    end
    
    private

    def self.next_turn
      @@grid.calculate_cells_next_states!
      @@grid.update_cells_states!
      @@count +=1
    end
    
end

GrimReaper.start_game!
