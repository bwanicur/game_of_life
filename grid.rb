require_relative 'cell'
require 'matrix'

class Grid
   
  attr_accessor :grid, :rows, :cols
   
   def initialize(seed_file_path)
     seed_data = load_seed(seed_file_path)
     @grid = grid_from_seed(seed_data)
   end
   
   def load_seed(seed_file_path)
       seed_data = []
       @cols = 0
       line_idx = 0
       File.open(seed_file_path, 'r').each_line do |line|
         my_line = []
         num_line_chars = 0
         char_idx = 0
         line.strip.each_char do |char|
           my_line << Cell.new(self, alive_or_dead?(char), char_idx, line_idx)
           num_line_chars += 1
           @cols = num_line_chars if num_line_chars > @cols
           char_idx += 1
         end
         @rows = line_idx + 1
         line_idx += 1
         seed_data << my_line
       end
       self.pad_seed_data(seed_data)
   end
   
   def pad_seed_data(seed_data)
       seed_data.each_with_index do |row, line_idx|
         if row.size < @cols
            row_size_diff = @cols - row.size
            char_idx = row.size
            row_size_diff.times do
              row <<  Cell.new(self, :dead, char_idx, line_idx)
              char_idx += 1
            end
         end
       end
       seed_data
   end
   
   def alive_or_dead?(char)
      if char == '.'
        :dead 
      else
        :alive 
      end
   end

   
   def grid_from_seed(seed_data)
      Matrix.rows(seed_data)
   end
   
   def cell_at(row, col)
       # if row, col is outside the grid bounds, return a dead cell
       
       # return Cell.new(self, :dead, row, col) if (row > rows || col > cols)
       # res = @grid.element(row,col)
       #if res.is_a?(Cell)
       #  res
       #else
       #  Cell.new(self, :dead, row, col)
       #end
       @grid.element(row,col) || Cell.new(self, :dead, row, col)
   end
   
   def next_turn!
     calculate_next
     update_state
   end

   private

   def calculate_next
     (0..rows).each do |row|
         (0..cols).each do |col|
             cell_at(row,col).calculate_next!
         end
     end
   end

   def update_state
     (0..rows).each do |row|
         (0..cols).each do |col|
             cell_at(row,col).update_state!
         end
     end
   end
   
   def alive_or_dead?(char)
      if char == '.'
        :alive
      else
        :dead
      end
   end
   
end
