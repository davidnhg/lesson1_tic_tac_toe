#
# Program:  ttt.rb (tic tac toe)
# Author:   David Nguyen
#
# Description:  The game has 9 cells, numbered 1, 2, 3, ..., 9.  Human player will start first, and he'll mark a cell with X.  The computer
#               will move next and mark a cell with O.  Each player will then take turn to mark the cells, one at a time.  Anyone with a triplet
#               of his own marks will win.  For example, if X is in 1st, 2nd and 3rd cells, then human will.
# Steps:
# => 0. Draw the game board
# => 1. Start the game and ask human to enter a number from { 1, 2, 3, 4, 5, 6, 7, 8, 9} set.  After the number is entered, mark the cell and
#       remove it from the available choices of the set.
# => 2. Repeat step one for the computer.
# => 3. Keep track of how many marks, both X and O, have been entered so far.  If the move is for the 5th mark, run the possible winning check.
# => 4. If there is no winner so far from step #3, repeat either #1 or #2 as the case might be.  Any move after the 5th move will trigger
#       the check on possible winnining.
# => 5. Do above steps until no more choice is left in the set.
# => 6. If we find a winner, declare the result and stop the current game.  Remember to ask if the human wants to play again.
require 'pry'

def draw_line(dash, offset, row_cell_opt_1 = '', row_cell_opt_2 = '', row_cell_opt_3 = '')
  # dash:           what kind of character to draw (-, |, etc.) 
  # offset:         number of spaces for spacing dashes
  # row cell opts:  X or O if the cell is marked by HUMAN or COMPUTER
  #

  if dash == "-"
    filler = dash
  else
    filler = " "
  end

  line_str =  row_cell_opt_1.rjust(offset, filler) + dash.rjust(offset, filler) +
              row_cell_opt_2.rjust(offset, filler) + dash.rjust(offset, filler) + row_cell_opt_3.rjust(offset, filler)

  puts line_str
  line_str = ''
end

def draw_vertical_dash(offset, temp_arr = '')
  if temp_arr == ''
    draw_line('|', offset, '', '', '')
  else
    draw_line('|', offset, temp_arr[0], temp_arr[1], temp_arr[2])
  end
end

def draw_horizonal_dash(offset)
  draw_line('-', offset)
end

def draw_board(chosen_choices)
  # Draw the game board so we can see where the cells are.
  #

  temp_arr = []

  # Draw the first line of the board
  draw_vertical_dash(4)

  # Draw the second line of the board
  (1..3).step(1) do |n|
    if chosen_choices.keys.include?(n.to_s)
      temp_arr << chosen_choices[n.to_s]
    else
      temp_arr << ''
    end
  end
  draw_vertical_dash(4, temp_arr)

  # Draw the third line of the board
  draw_vertical_dash(4)

  # Draw the fourth line of the board
  draw_horizonal_dash(5)

  # Draw the 5th line of the board
  draw_vertical_dash(4)

  # Draw the 6th line of the board
  temp_arr.clear
  (4..6).step(1) do |n|
    if chosen_choices.keys.include?(n.to_s)
      temp_arr << chosen_choices[n.to_s]
    else
      temp_arr << ''
    end
  end
  draw_vertical_dash(4, temp_arr)

  # Draw the 7th line of the board
  draw_vertical_dash(4)

  # Draw the 8th line of the board
  draw_horizonal_dash(5)

  # Draw the 9th line of the board
  draw_vertical_dash(4)

  # Draw the 10th line of the board
  temp_arr.clear
  (7..9).step(1) do |n|
    if chosen_choices.keys.include?(n.to_s)
      temp_arr << chosen_choices[n.to_s]
    else
      temp_arr << ''
    end
  end
  draw_vertical_dash(4, temp_arr)

  # Draw the 11th line of the board
  draw_vertical_dash(4)

end # draw_board

def say(sentence)
  puts sentence
end

def choose_move(available_choices, type = 'HUMAN')
  # Prompt for a move and delete the chosen cell from available pool.
  #

  if available_choices.size > 0
    if type == 'HUMAN'
      say "Choose a position (from 1 to 9) to place a piece:"
      begin
        input = gets.chomp
      end until available_choices.include?(input)
    else
      input = available_choices.sample
    end
    available_choices.delete(input)
    return input
  else
    puts "No more cell available to choose!"
    return nil
  end
end

def record_move(chosen_choices, type = 'HUMAN', cell_number)
  # Keep track of the moves
  #

  if type == 'HUMAN'
    chosen_choices[cell_number] = 'X'
  else
    chosen_choices[cell_number] = 'O'
  end
end

def winner_is?(move_count, chosen_choices)
  # Check all possible winning paths:
  # => 1.  123
  # => 2.  456
  # => 3.  789
  # => 4.  147
  # => 5.  258
  # => 6.  369
  # => 7.  159
  # => 8.  357
  #

  if move_count < 5
    return false
  else
    # Check paths
    case
    when (chosen_choices['1'] == chosen_choices['2']) && (chosen_choices['1'] == chosen_choices['3']) 
      chosen_choices['1'] == 'X' ? 'X' : 'O'
    when (chosen_choices['4'] == chosen_choices['5']) && (chosen_choices['4'] == chosen_choices['6']) 
      chosen_choices['4'] == 'X' ? 'X' : 'O'
    when (chosen_choices['7'] == chosen_choices['8']) && (chosen_choices['7'] == chosen_choices['9']) 
      chosen_choices['7'] == 'X' ? 'X' : 'O'
    when (chosen_choices['1'] == chosen_choices['4']) && (chosen_choices['1'] == chosen_choices['7']) 
      chosen_choices['1'] == 'X' ? 'X' : 'O'
    when (chosen_choices['2'] == chosen_choices['5']) && (chosen_choices['2'] == chosen_choices['8']) 
      chosen_choices['2'] == 'X' ? 'X' : 'O'
    when (chosen_choices['3'] == chosen_choices['6']) && (chosen_choices['3'] == chosen_choices['9']) 
      chosen_choices['3'] == 'X' ? 'X' : 'O'
    when (chosen_choices['1'] == chosen_choices['5']) && (chosen_choices['1'] == chosen_choices['9']) 
      chosen_choices['1'] == 'X' ? 'X' : 'O'
    when (chosen_choices['3'] == chosen_choices['5']) && (chosen_choices['3'] == chosen_choices['7']) 
      chosen_choices['3'] == 'X' ? 'X' : 'O'
    end
  end
end

# Main
chosen_choices = {}
continue = 'Y'
cells_arr =  ['1', '2', '3',
              '4', '5', '6',
              '7', '8', '9']
available_choices = []

while continue == 'Y' do
  chosen_choices.clear
  available_choices.clear
  available_choices = cells_arr.map { |c| c }

  draw_board(chosen_choices)

  move_count = 0

  begin
    cell_number = choose_move(available_choices)
    record_move(chosen_choices, 'HUMAN', cell_number)
    move_count +=1
    possible_winner = winner_is?(move_count, chosen_choices)
    if possible_winner == 'X'
      puts "You win!"
      break
    elsif possible_winner == 'O'
      puts "Computer win!"
      break
    end


    cell_number = choose_move(available_choices, 'COMPUTER')
    record_move(chosen_choices, 'COMPUTER', cell_number)
    move_count +=1
    possible_winner = winner_is?(move_count, chosen_choices)
    if possible_winner == 'X'
      puts "You win!"
      break
    elsif possible_winner == 'O'
      puts "Computer win!"
      break
    end

    draw_board(chosen_choices)
  end until available_choices.size == 0

  # Ask if user wants to play again
  draw_board(chosen_choices)
  say "Play again? (Y/N)"
  continue = gets.chomp.upcase

end