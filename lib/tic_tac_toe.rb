class TicTacToe
  def initialize
    @board = Array.new(9," ")
  end
  WIN_COMBINATIONS = [
  [0,1,2], #Top row
  [3,4,5], #Middle row
  [6,7,8], #Bottom row
  [0,3,6], #Left col
  [1,4,7], #Middle col
  [2,5,8], #Right col
  [0,4,8], #Diag 1
  [6,4,2]  #Diag 2
  ]

  def display_board
  divider = "-----------"
  puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
  puts divider
  puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
  puts divider
  puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
end

def move(num,char = "X")
  @board[(num.to_i) - 1] = char
end

def position_taken?(position)
  if (@board[position] == "X" || @board[position] == "O")
    true
  else
    false
  end
end

def valid_move?(input)
  if input.to_i().between?(1,9) && !(position_taken?(input.to_i()-1))
    true
  end
end

def turn
  puts "Please enter 1-9:"
  input = gets.strip()
  if valid_move?(input)
    move(input, current_player)
    display_board
  else
    turn
  end

end

def turn_count
  @board.count{|token| token == "X" || token == "O"}
end

def current_player
  turn_count % 2 == 0 ? "X" : "O"
end

def won?
  #for each winning array, check to see if the values
  #on the board are all X's or all O's

  WIN_COMBINATIONS.each do |win| #
    if (win.all?{|i| @board[i].eql? "X"} || win.all?{|i| @board[i].eql? "O"})
      return win
    end
  end
  return false
end

def full?
  #determine if all elements of the board
  #are not equal to " "
  @board.all?{|i| !(i.eql? " ")}
end

def draw?
  #check if board is full and no one has won
  full? && !(won?)
end

def winner
  #the winner is token at one of the winning indexes

  if won?
    return @board[won?[0]]
  else
    return nil
  end
end

def over?
  #check if board is full and no one has won
  draw? || won?
end

def play
  if !over?
    turn
    play
  end
  if draw?
    puts "Cats Game!"
  elsif won?
    puts "Congratulations #{winner}!"
  end
end

end