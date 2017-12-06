class Game

  BOARD = {"1" => "1", "2" => "2", "3" => "3",
              "4" => "4", "5" => "5", "6" => "6",
              "7" => "7", "8" => "8", "9" => "9"}
  BOARD_WINS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
  CELLS = %w[1 2 3 4 5 6 7 8 9]
  TOKENS = %w[X O]

  def finished(val)
    @finished = val
  end

  # Game plays
  def start

    puts "WELCOME TO TIC TAC TOE"
    display_board

    while !@finished
      x_plays
      check_board
      display_board

      o_plays
      check_board
      display_board

    end
  end

  # Display contents of board
  def display_board
    puts ""
    puts " #{BOARD["1"]} | #{BOARD["2"]} | #{BOARD["3"]} "
    puts "-----------"
    puts " #{BOARD["4"]} | #{BOARD["5"]} | #{BOARD["6"]} "
    puts "-----------"
    puts " #{BOARD["7"]} | #{BOARD["8"]} | #{BOARD["9"]} "
    puts ""
  end

  # Player X (user) plays
  def x_plays
    puts "X's turn..."
    flag = true

    # Make sure to get the correct input from user
    while flag do
      puts ""
      print "Enter cell number: [1-9]: "
      cell = gets.chomp

      if !CELLS.include?(cell)
        puts "\nPlease choose a number between 1 and 9\n"
        flag = true
      elsif TOKENS.include?BOARD[cell]
        puts "\nCell chosen is taken. Please choose another cell\n"
        flag = true
      else
        flag = false
      end
    end

    BOARD[cell] = 'X'
  end

  # Player 0 (computer) plays
  def o_plays
    puts "O's turn..."
    puts ""

    found = false
    cell = get_position

    # If X wins next turn, take his/her winning position
    if cell > 0
      found = true
    end

    # Otherwise, pick cell at random
    while !found
      cell = 1 + rand(8)
      if BOARD["#{cell}"] != 'X' and BOARD["#{cell}"] != 'O'
        found = true
      end
    end

    BOARD["#{cell}"] = 'O'
  end

  # Return position that will either produce a win for X or O, return -1 otherwise
  def get_position
    xNum = 0
    oNum = 0
    position_to_take = -1

    BOARD_WINS.each do |seq|
      seq.each do |cell|
        if BOARD["#{cell}"] == 'X'
          xNum += 1
        elsif BOARD["#{cell}"] == 'O'
          oNum += 1
        else
          position_to_take = cell
        end
      end

      if (xNum == 2 or oNum == 2) and position_to_take > 0
        break;
      else
        xNum = 0
        oNum = 0
        position_to_take = -1
      end
    end

    return position_to_take
  end

  # Return true if a winner is found, return false otehrwise
  def has_winner
    xNum = 0
    oNum = 0
    BOARD_WINS.each do |seq|
      seq.each do |cell|
        pos = BOARD["#{cell}"]
        if pos == 'X'
          xNum += 1
        elsif pos == 'O'
          oNum += 1
        end
      end

      if xNum == 3 or oNum == 3
        break # we found a winner, no need to keep looking
      else # reset counters
        xNum = 0
        oNum = 0
      end
    end

    if xNum == 3
      puts "X wins!"
      return true
    elsif oNum == 3
      puts "O wins!"
      return true
    else
      return false
    end
  end

  # Return true if board is full, return false otherwise
  def is_full
    CELLS.each do |cell|
      if BOARD[cell] != 'X' and BOARD[cell] != 'O'
        return false
      end
    end
    return true
  end

  # Check if winner or draw
  def check_board
    if has_winner
      finished(true)
    elsif is_full
      puts "IT'S A DRAW"
      finished(true)
    end
  end
end

new_game = Game.new
new_game.start