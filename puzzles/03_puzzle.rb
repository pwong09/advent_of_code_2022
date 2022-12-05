# frozen_string_literal: true

require '../elves_data'
include ElvesData

# split input into array based on empty lines
@file_data = ElvesData.read_file('../input/03_input.txt', /\n/)

@hash = Hash[('a'..'z').to_a.zip((1..26).to_a)].merge(Hash[('A'..'Z').to_a.zip((27..57).to_a)])

def common_items(array)
  points = 0
  rucksacks = split_list(array)

  rucksacks.each do |rucksack|
    shared_items = []
    rucksack.first.each_char { |item| shared_items.push(item) if rucksack.last.include?(item) }
    shared_items.uniq.each { |item| points += @hash[item] }
  end

  points
end

def split_list(array)
  array.map do |rucksack|
    mid_idx = rucksack.length / 2
    first_compartment = rucksack.slice(0, mid_idx)
    second_compartment = rucksack.slice(mid_idx, rucksack.length)

    [first_compartment, second_compartment]
  end
end

puts common_items(@file_data)

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