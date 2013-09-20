require_relative 'cell'
require 'matrix'

class Grid
   
  attr_accessor :grid, :num_rows, :num_cols
   
   def initialize(seed_file_path)
     seed_data = load_seed(seed_file_path)
     # @grid = grid_from_seed(seed_data)
     @grid = seed_data
   end
   
   def load_seed(seed_file_path)
     seed_data = []
     @num_cols = 0
     line_idx = 0
     File.open(seed_file_path, 'r').each_line do |line|
       my_line = []
       num_line_chars = 0
       char_idx = 0
       line.strip.each_char do |char|
         my_line << Cell.new(self, alive_or_dead?(char), char_idx, line_idx)
         num_line_chars += 1
         @num_cols = num_line_chars if num_line_chars > @num_cols
         char_idx += 1
       end
       @num_rows = line_idx + 1
       line_idx += 1
       seed_data << my_line
     end
     # self.pad_seed_data(seed_data)
     seed_data
   end
   
   def pad_seed_data(seed_data)
     seed_data.each_with_index do |row, line_idx|
       if row.size < @num_cols
         row_size_diff = @num_cols - row.size
         char_idx = row.size
         row_size_diff.times do
           row <<  Cell.new(self, :dead, char_idx, line_idx)
           char_idx += 1
         end
       end
     end
     seed_data
   end
   
   def grid_from_seed(seed_data)
      Matrix.rows(seed_data)
   end
   
   def cell_at(row, col)
     # if row, col is outside the grid bounds, return a dead cell
     if out_of_bounds?(row, col)
       Cell.new(self, :dead, row, col)
     else
       #@grid.element(row, col) 
       @grid[row][col]
     end
   end
   
   def next_turn!
     calculate_next
     update_state
   end

   private

   def calculate_next
     (0...@num_rows).each do |row|
       (0...@num_cols).each do |col|
         cell_at(row,col).calculate_next!
       end
     end
   end

   def update_state
     (0...@num_rows).each do |row|
       (0...@num_cols).each do |col|
         cell_at(row,col).update_state!
       end
     end
   end
   
   def alive_or_dead?(char)
    if char == '.'
      :dead
    else
      :alive
    end
   end

   def out_of_bounds?(col, row)
     bool = false
     bool = true if (col < 0 || row < 0)
     bool = true if (col > (@num_cols - 1) || row > (@num_rows - 1)) # @num_cols and @num_rows are not 0-based, so subtract 1
     bool
   end 

end
