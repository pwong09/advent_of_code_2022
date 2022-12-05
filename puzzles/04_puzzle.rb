# frozen_string_literal: true

require '../elves_data'
include ElvesData

# split input into array based on empty lines
file_data = ElvesData.read_file('../input/04_input.txt', /\n/)

def find_full_overlap(array)
  points = 0
  pairs = ElvesData.split_pairs(array)

  pairs.each { |pair| points += ElvesData.check_overlap(pair, 'full') }
  points
end

puts 'full range overlap'
puts find_full_overlap(file_data)

def find_any_overlap(array)
  points = 0
  pairs = ElvesData.split_pairs(array)

  pairs.each { |pair| points += ElvesData.check_overlap(pair, 'any') }

  points
end

puts 'any section overlap'
puts find_any_overlap(file_data)
