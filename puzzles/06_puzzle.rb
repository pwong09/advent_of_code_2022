# frozen_string_literal: true

require '../elves_data'

include ElvesData

data = read_file('../input/06_input.txt', /''/)[0].split('')

def find_marker(array, count)
  array.each_index do |idx|
    next if idx + 1 < count

    chars = []
    ((idx + 1 - count)..idx).each do |j|
      chars.push(array[j]) unless chars.include?(array[j])
    end

    return idx + 1 if chars.length == count
  end
end

puts 'find marker at 4 unique chars'
puts find_marker(data, 4)

puts 'find marker at 14 unique chars'
puts find_marker(data, 14)
