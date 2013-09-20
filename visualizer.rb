class Visualizer
    
    @@count = 1 
    def self.ascii(grid)
        puts "#{@@count} ==========================="
        (0..grid.cols).each do |col|
            (0..grid.rows).each do |row|
              print (grid.cell_at(row,col).alive? ? "*" : ".")
            end
         print "\n"
        end
        puts
        @@count +=1
    end
end
