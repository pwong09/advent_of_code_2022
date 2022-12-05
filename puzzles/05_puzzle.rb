# frozen_string_literal: true

require 'csv'
require '../elves_data'
include ElvesData

moves_data = ElvesData.read_file('../input/05_input.txt', /\n/)[10..]

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
