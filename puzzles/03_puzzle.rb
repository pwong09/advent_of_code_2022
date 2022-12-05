# frozen_string_literal: true

require '../elves_data'
include ElvesData

# split input into array based on empty lines
@file_data = ElvesData.read_file('../input/03_input.txt', /\n/)

@hash = Hash[('a'..'z').to_a.zip((1..26).to_a)].merge(Hash[('A'..'Z').to_a.zip((27..57).to_a)])

def common_items(array)
  points = 0
  rucksacks = ElvesData.split_list(array)

  rucksacks.each do |rucksack|
    compartment1 = rucksack[0].split('')
    compartment2 = rucksack [1].split('')

    compartment1.map { |item| item if compartment2.include?(item) }
                .compact.uniq.each { |item| points += @hash[item] }
  end

  points
end

puts common_items(@file_data)

def badge(array)
  points = 0
  groups = ElvesData.group_of_three(array)

  groups.each do |group|
    group[0].map { |item| item if group[1].include?(item) && group[2].include?(item) }.compact
            .uniq.each { |item| points += @hash[item] }
  end

  points
end

puts badge(@file_data)
