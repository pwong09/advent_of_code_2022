# frozen_string_literal: true

require './01_puzzle'

def top_three_elves(array)
  total_cal_per_elf = []
  array.each { |elf| total_cal_per_elf.push(elf.split(/\n/).map(&:to_f).reduce(:+)) }

  total_cal_per_elf.sort.reverse.slice(0, 3).reduce(:+)
end

puts 'sum calories of top 3 elves'
puts top_three_elves(@file_data)
