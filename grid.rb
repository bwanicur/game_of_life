require_relative 'cell'

class Grid
   
  attr_accessor :grid, :num_rows, :num_cols
   
   def initialize(seed_data)
     @grid = seed_data
     @num_rows = seed_data.size
     @num_cols = seed_data[0].size # grid should always be a square, so all rows should have the same length
   end
   
   def calculate_cells_next_states!
     num_alive_neighbors = 0 
     @grid.each do |row|
       row.each do |cell|
         (-1..1).each do |offset_row|
           (-1..1).each do |offset_col|
             next if cell_at(cell.row + offset_row, cell.col + offset_col) == cell
             num_alive_neighbors += 1 if cell_at(cell.row + offset_row, cell.col + offset_col).alive?
           end
         end
         cell.num_alive_neighbors = num_alive_neighbors
         cell.calculate_next_state!
         num_alive_neighbors = 0 
       end
     end
   end

   def update_cells_states!
     @grid.each do |row|
       row.each do |cell|
         cell.update_state!
       end
     end
   end
   
   private 

   def alive_or_dead?(char)
    if char == '.'
      :dead
    else
      :alive
    end
   end

   def cell_at(row, col)
     # if row, col is outside the grid bounds, return a dead cell
     if out_of_bounds?(row, col)
       Cell.new(:dead, row, col)
     else
       @grid[row][col]
     end
   end
   
   def out_of_bounds?(col, row)
     bool = false
     bool = true if (col < 0 || row < 0)
     bool = true if (col > (@num_cols - 1) || row > (@num_rows - 1)) # @num_cols and @num_rows are not 0-based, so subtract 1
     bool
   end 

end
