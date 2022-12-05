# frozen_string_literal: true

require '../elves_data'
include ElvesData
# split input into array based on empty lines
@file_data = ElvesData.read_file('../input/01_input.txt', /\n\n/)

def max_calories(array)
  ElvesData.sum(array).max
end

puts 'elf with highest sum of calories in snacks'
puts max_calories(@file_data)

def top_three_elves(array)
  ElvesData.sum(array).reverse.slice(0, 3).reduce(:+)
end

puts 'sum calories of top 3 elves'
puts top_three_elves(@file_data)
