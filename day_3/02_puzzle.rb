# frozen_string_literal: true

require './01_puzzle'

def find_badge(array)
  points = 0
  groups = array.each_slice(3).to_a

  groups.each do |group|
    shared_items = []
    group.first.each_char do |item|
      shared_items.push(item) if group[1].include?(item) && group.last.include?(item)
    end
    points += @hash[shared_items.uniq.first]
  end

  points
end

puts find_badge(@file_data)
