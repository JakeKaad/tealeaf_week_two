  claimed_squares = {1 => "_", 2 => "_", 3 => "_", 4 => "x", 5 => "_", 6 => "x", 7 => "_", 8 => "_", 9 => "_"}
  WINNING_ARRAYS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
  marker = "x"
  
  def two_in_a_row?(claimed_squares, marker)
    not_empty_two_in_a_row = WINNING_ARRAYS.select do |a|
                      [claimed_squares[a[0]], claimed_squares[a[1]], claimed_squares[a[2]]].sort == ["_", marker, marker]
                    end
    not_empty_two_in_a_row.empty?
  end
  
  def two_in_a_row(claimed_squares, marker)
    
    two_in_array = WINNING_ARRAYS.select do |a|
                      [claimed_squares[a[0]], claimed_squares[a[1]], claimed_squares[a[2]]].sort == ["_", marker, marker]
                   end
    p two_in_array
    two_in_array.flatten.select do |n|
      claimed_squares[n] == "_"
    end
  end
  
p "hi" if two_in_a_row?(claimed_squares, marker)
p two_in_a_row(claimed_squares, marker)


 
  
  