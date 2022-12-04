# frozen_string_literal: true

# split input into array based on empty lines
@file_data = File.read('01_input.txt').split(/\n\n/)

def max_calories(array)
  max = 0
  array.each do |el|
    sum = el.split(/\n/).map(&:to_f).reduce(:+)
    max = sum if sum > max
  end

  max
end

puts 'elf with highest sum of calories in snacks'
puts max_calories(@file_data)
