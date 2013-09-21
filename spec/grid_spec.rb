require_relative '../grid'

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


end
