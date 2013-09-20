class Visualizer
    
    @@count = 1 
    
    def self.ascii(grid)
        puts "#{@@count} ==========================="
        grid.cols.times do |col|
            grid.rows.times do |row|
              print (grid.cell_at(row,col).alive? ? "*" : ".")
            end
         print "\n"
        end
        puts
        @@count +=1
    end
end
