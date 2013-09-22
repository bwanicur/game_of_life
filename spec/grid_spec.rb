require_relative '../grid'

# returns a grid with this format:
# [
#   [alive, alive, dead],
#   [alive, dead,  dead],
#   [dead,  dead,  dead]
# ] 
def three_row_grid
  grid = []
  grid << [
    Cell.new(:alive, 0, 0),
    Cell.new(:alive, 0, 1),
    Cell.new(:dead, 0, 2)
  ]
  grid << [
    Cell.new(:alive, 1, 0),
    Cell.new(:dead, 1, 1),
    Cell.new(:dead, 1, 2)
  ]
  grid << [
    Cell.new(:dead, 2, 0),
    Cell.new(:dead, 2, 1),
    Cell.new(:dead, 2, 2)
  ]
  grid
end

describe Grid do

  it "should initialize with a grid, num_rows, and num_cols" do
    grid_data = three_row_grid
    grid = Grid.new(grid_data)
    grid.grid.should == grid_data
    grid.num_rows.should == 3
    grid.num_cols.should == 3
  end

  it "should be able to calculate each cell's next state" do
    grid_data = three_row_grid
    grid = Grid.new(grid_data)
    grid.grid[0][0].state.should == :alive
    grid.grid[0][1].state.should == :alive
    grid.grid[0][2].state.should == :dead
    
    grid.grid[1][0].state.should == :alive
    grid.grid[1][1].state.should == :dead
    grid.grid[1][2].state.should == :dead
    
    grid.grid[2][0].state.should == :dead
    grid.grid[2][1].state.should == :dead
    grid.grid[2][2].state.should == :dead
   
    grid.calculate_cells_next_states!
    grid.grid[0][0].num_alive_neighbors.should == 2
    grid.grid[0][0].next_state.should == :alive 
    grid.grid[0][1].num_alive_neighbors.should == 2
    grid.grid[0][1].next_state.should == :alive 
    grid.grid[0][2].num_alive_neighbors.should == 1
    grid.grid[0][2].next_state.should == :dead

    grid.grid[1][0].num_alive_neighbors.should == 2
    grid.grid[1][0].next_state.should == :alive 
    grid.grid[1][1].num_alive_neighbors.should == 3
    grid.grid[1][1].next_state.should == :alive 
    grid.grid[1][2].num_alive_neighbors.should == 1
    grid.grid[1][2].next_state.should == :dead
    
    grid.grid[2][0].num_alive_neighbors.should == 1
    grid.grid[2][0].next_state.should == :dead 
    grid.grid[2][1].num_alive_neighbors.should == 1
    grid.grid[2][1].next_state.should == :dead
    grid.grid[2][2].num_alive_neighbors.should == 0
    grid.grid[2][2].next_state.should == :dead
  end


end
