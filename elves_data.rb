# frozen_string_literal: true

# Data model that extracts file and parses based on requirements
module ElvesData
  # Splits a text file per regex (like a line break, blank line, comma, etc)
  #
  # @params String: file name
  # @returns Array
  def read_file(file, regex)
    File.read(file).split(regex)
  end

  # Maps a new array summing each elf's inventory using a line break
  #
  # @params Array
  # @returns sorted Array
  def sum(array)
    array.map { |el| el.split(/\n/).map(&:to_f).reduce(:+) }.sort
  end

  # Splits each rucksack into 2 compartments (in half)
  #
  # @params Array
  # @returns Array (2 elements) of an Array (n elements) - [ [1, 2], [1, 2] ]
  def split_list(array)
    array.map do |rucksack|
      mid_idx = rucksack.length / 2
      first_compartment = rucksack.slice(0, mid_idx)
      second_compartment = rucksack.slice(mid_idx, rucksack.length)

      [first_compartment, second_compartment]
    end
  end

  # Splits elves into groups of three
  #
  # @params Array
  # @returns Array (3 elements) within an Array (n elements) - [ [1, 2, 3], [4, 5, 6] ]
  def group_of_three(array)
    groups = array.each_slice(3).to_a

    groups.map do |group|
      [group[0].split(''), group[1].split(''), group[2].split('')]
    end
  end

  # Splits elves' cleaning sections into pairs, then converts sections into a range
  #
  # @params Array
  # @returns Array (2 elements) within an Array (n elements) - [ [1, 2], [3, 4] ]
  def split_pairs(array)
    pairs = array.map { |pair| pair.split(',') }.map do |pair|
      [pair[0].split('-').map(&:to_i), pair[1].split('-').map(&:to_i)]
    end
    translate_to_range(pairs)
  end

  # Outputs custom range of numbers into separate Arrays
  #
  # @params Array (2 elements) within an Array (m elements)
  # @returns Array (range of elements) within an Array (m elements) within an Array (n elements)
  # Example - [ [ [0, 1, 2], [1, 2, 3] ], [ [2, 3, 4], [5, 6, 7] ] ]
  def translate_to_range(pairs)
    pairs.map do |pair|
      [(pair[0][0]..pair[0][1]).to_a, (pair[1][0]..pair[1][1]).to_a]
    end
  end

  def check_overlap(pair, type = 'full')
    count = 0

    case type
    when 'full'
      if  pair[0].include?(pair[1][0]) && pair[0].include?(pair[1][-1]) ||
          pair[1].include?(pair[0][0]) && pair[1].include?(pair[0][-1])
        count += 1
      end
    when 'any'
      if  (pair[0].include?(pair[1][0]) || pair[0].include?(pair[1][-1])) ||
          pair[1].include?(pair[0][0]) || pair[1].include?(pair[0][-1])
        count += 1
      end
    end

    count
  end

  def translate_move(array)
    array.map do |move|
      move = move.split(' ')
      [move[1].to_i, move[3], move[5]]
    end
  end
end
