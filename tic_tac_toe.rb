WIN_COMBINATIONS = [
	[0, 1, 2], # Top row
	[3, 4, 5], # Middle row across
	[6, 7, 8], # Bottom row
	[0, 3, 6], # Left column
	[1, 4, 7], # Center column
	[2, 5, 8], # Right column
	[6, 4, 2], # Diagonal bottom left to top right
	[0, 4, 8]  # Diagonal top left to bottom right
]

BOARD_MATRIX = {
	"A1" => 0, 
	"A2" => 3, 
	"A3" => 6, 
	"B1" => 1, 
	"B2" => 4, 
	"B3" => 7, 
	"C1" => 2, 
	"C2" => 5, 
	"C3" => 8
}

def display_board(b)
	puts "     A   B   C  "
	puts "                "
	puts "   +---+---+---+"
	puts "1  | #{b[0]} | #{b[1]} | #{b[2]} |"
	puts "   +---+---+---+"
	puts "2  | #{b[3]} | #{b[4]} | #{b[5]} |"
	puts "   +---+---+---+"
	puts "3  | #{b[6]} | #{b[7]} | #{b[8]} |"
	puts "   +---+---+---+"
end

def x_or_o?
	puts "Which player do you want to be? X or O?"
	player_mark = gets.chomp

	until player_mark.to_s == "X" || player_mark.to_s == "O"
    puts "Which player do you want to be? X or O?"
		player_mark = gets.chomp
	end

	player_mark
end

def player_move(board, board_matrix, x_or_o)
	display_board(board)

	puts "Where do you want to move?"
	player_move = gets.chomp

  add_move_to_board(board, BOARD_MATRIX, player_move, x_or_o)
end

def computer_move(board, board_matrix, x_or_o)
	computer_mark = x_or_o == "X" ? "O" : "X"
    
  player_combos = board.each_index.select do |index|
		board[index] == x_or_o
	end

	computer_combos = board.each_index.select do |index|
		board[index] == computer_mark
	end
    
	x_or_o_combos = player_combos + computer_combos

	open_spots = board_matrix.delete_if do |k, v|
		x_or_o_combos.include?(v)
	end

	computer_move = open_spots.keys.sample

	if player_combos.count - 1 == computer_combos.count
		add_move_to_board(board, BOARD_MATRIX, computer_move, computer_mark)
	end
end

def position_taken?(board, board_matrix, player_move)
	position = board_matrix[player_move]
	true if board[position] != " "
end

def valid_move?(board, board_matrix, move)
	true if board_matrix.keys.include?(move) && !position_taken?(board, board_matrix, move)
end

def add_move_to_board(board, board_matrix, move, x_or_o)
	if valid_move?(board, board_matrix, move)
		board[board_matrix[move]] = x_or_o
	end
end

def game_won?(board)
	x_combos = board.each_index.select { |x| board[x] == "X" }
	o_combos = board.each_index.select { |o| board[o] == "O" }

	if WIN_COMBINATIONS.include?(x_combos)
		puts "X has won!"
		return true
	elsif WIN_COMBINATIONS.include?(o_combos)
		puts "O has won!"
		return true
	end
end

def play_game(board)
	player_mark = x_or_o?

	until game_won?(board)
		player_move(board, BOARD_MATRIX, player_mark)
		computer_move(board, BOARD_MATRIX, player_mark)
	end
end

board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

play_game(board)