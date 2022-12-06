# frozen_string_literal: true

require 'csv'
require '../elves_data'
include ElvesData

moves_data = ElvesData.read_file('../input/05_input.txt', /\n/)[10..]

stacks_data = ElvesData.read_file('../input/05_input.txt', /\n\n/)[0..9]

puts stacks_data[0].split('\n')

# def rotate_stacks(data)
#   col_width = 4
#   rotated_stack = []
#   rows = data.split('\n')

#   for (let z = rows.length - 2; z >= 0; z--) {
#     row = rows[z]
#     this_col = 9
#     for (let i = row.length - 1; i >= 0; i -= colWidth) {
#       if (!Array.isArray(rotatedStack[thisCol])) {
#         rotatedStack[thisCol] = [];
#       }

#       this_cell = row[i - 1];
#       if (this_cell != ' ') rotated_stack[this_col].push(this_cell);
#       this_col -= 1
#       if (this_col == 0) this_col = 9;
#     }
#   }
#   this.stacks = rotatedStack;
# end

@stacks = { '1' => ['S', 'T', 'H', 'F', 'W', 'R'],
            '2' => ['S', 'G', 'D', 'Q', 'W'],
            '3' => ['B', 'T', 'W'],
            '4' => ['D', 'R', 'W', 'T', 'N', 'Q', 'Z', 'J'],
            '5' => ['F', 'B', 'H', 'G', 'L', 'V', 'T', 'Z'],
            '6' => ['L', 'P', 'T', 'C', 'V', 'B', 'S', 'G'],
            '7' => ['Z', 'B', 'R', 'T', 'W', 'G', 'P'],
            '8' => ['N', 'G', 'M', 'T', 'C', 'J', 'R'],
            '9' => ['L', 'G', 'B', 'W']}

@stacks_copy = @stacks.dup

# ElvesData.translate_move(moves_data).each do |move|
#   (1..move[0]).each { |_| @stacks[move[2]].push(@stacks[move[1]].pop) }
# end

# puts 'move crate individually'
# puts @stacks

ElvesData.translate_move(moves_data).each do |move|
  @stacks[move[2]].append(@stacks[move[1]].pop(move[0])).flatten!
end

puts 'move crates together'
puts @stacks
