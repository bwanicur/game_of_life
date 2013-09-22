require_relative 'cell'

## NOTE: All seed files must adhere to the following rule:  The number of rows must be equal to the longest column.  
#        All shorter columns are padded with "dead" cells.  The seed file must represent a square.
class SeedFileParser
  
  def self.parse_file(seed_file_path)
     seed_data = []
     @@num_cols = 0
     line_idx = 0
     File.open(seed_file_path, 'r').each_line do |line|
       my_line = []
       num_line_chars = 0
       char_idx = 0
       line.strip.each_char do |char|
         state = char == '.' ? :dead : :alive
         my_line << Cell.new(state, char_idx, line_idx)
         num_line_chars += 1
         @@num_cols = num_line_chars if num_line_chars > @@num_cols
         char_idx += 1
       end
       line_idx += 1
       seed_data << my_line
     end
     seed_data = self.pad_seed_data(seed_data)
     seed_data
   end
   
   def self.pad_seed_data(seed_data)
     seed_data.each_with_index do |row, line_idx|
       if row.size < @@num_cols
         row_size_diff = @@num_cols - row.size
         char_idx = row.size
         row_size_diff.times do
           row <<  Cell.new(:dead, char_idx, line_idx)
           char_idx += 1
         end
       end
     end
     seed_data
   end

end
