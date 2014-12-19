  claimed_squares = {1 => "x", 2 => "x", 3 => "x", 4 => "_", 5 => "_", 6 => "_", 7 => "_", 8 => "_", 9 => "_"}
  WINNING_ARRAYS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
  marker = "x"
  
  def winner?(claimed_squares, marker)
    not_empty_wins = WINNING_ARRAYS.select do |a|
                      [claimed_squares[a[0]], claimed_squares[a[1]], claimed_squares[a[2]]] == [marker, marker, marker]
                    end
    !not_empty_wins.empty?
  end
  
 p winner?(claimed_squares, marker)
 
  
  