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
      pair1 = pair.first.split('-')
      pair2 = pair.last.split('-')
      pair11 = pair1.first.to_i
      pair12 = pair1.last.to_i
      pair21 = pair2.first.to_i
      pair22 = pair2.last.to_i

      [[pair11, pair12], [pair21, pair22]]
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
      range1 = (pair[0][0]..pair[0][1]).to_a
      range2 = (pair[1][0]..pair[1][1]).to_a

      [range1, range2]
    end
  end

  def check_overlap(pair, type = 'full')
    count = 0
    range1 = pair[0]
    range2 = pair[1]

    case type
    when 'full'
      if range1.length > range2.length
        count += 1 if range1.include?(range2[0]) && range1.include?(range2[-1])
      elsif range2.include?(range1[0]) && range2.include?(range1[-1])
        count += 1
      end
    when 'any'
      if range1.length > range2.length
        count += 1 if range1.include?(range2[0]) || range1.include?(range2[-1])
      elsif range2.include?(range1[0]) || range2.include?(range1[-1])
        count += 1
      end
    end

    count
  end
end
