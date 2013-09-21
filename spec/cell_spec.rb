require_relative '../cell'

describe Cell do
  
  it "should instansiate with a state, row_idx, and col_idx" do
    cell = Cell.new(:alive, 0, 0)
    cell.state.should == :alive
    cell.row.should == 0
    cell.col.should == 0
  end

  it "shoud know if it is alive or dead" do
    cell = Cell.new(:alive, 0, 0)
    cell.alive?.should == true
    cell.dead?.should == false 
  end

  it "should be able to update its state" do
    cell = Cell.new(:alive, 0, 0)
    cell.next_state = :dead
    cell.state.should == :alive
    cell.next_state.should == :dead
    cell.update_state!
    cell.state.should == :dead
  end

  it "should be able to calculate its next_state" do
      ## RULES:
      # Any live cell with fewer than two live neighbours dies, as if caused by under-population.
      # Any live cell with two or three live neighbours lives on to the next generation.
      # Any live cell with more than three live neighbours dies, as if by overcrowding.
      # Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
      
      cell = Cell.new(:alive, 0, 0)
      
      cell.num_alive_neighbors = 2 
      cell.calculate_next_state!
      cell.next_state.should == :alive
      
      cell.num_alive_neighbors = 1
      cell.calculate_next_state!
      cell.next_state.should == :dead

      cell.num_alive_neighbors = 4
      cell.calculate_next_state!
      cell.next_state.should == :dead

      cell.state = :dead
      cell.num_alive_neighbors = 2
      cell.calculate_next_state!
      cell.next_state.should == :dead

      cell.num_alive_neighbors = 3
      cell.calculate_next_state!
      cell.next_state.should == :alive

      cell.num_alive_neighbors = 5
      cell.calculate_next_state!
      cell.next_state.should == :dead
  end
end
